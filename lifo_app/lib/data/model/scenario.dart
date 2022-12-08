
import 'package:lifo_app/data/model/Tube.dart';



int maxColors = 0;
int extraTubes = 2; //usually
class Scenario {
  final List <Tube> content = <Tube>[];

  Scenario.fromList(List <Tube> tubes) {
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      Tube newTube = Tube();
      Tube oldTube = tubes[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        int ball = oldTube.content[slot];
        newTube.content.add(ball);
      }
      content.add(newTube);
    }
  }

  Scenario.fromColors(List <List<int>> listOfColors) {
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      Tube newTube = Tube();
      List<int> oldTube = listOfColors[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        int ball = oldTube[slot];
        newTube.content.add(ball);
      }
      content.add(newTube);
    }
  }
  int tubePop = 0;
  int tubePush = 0;
  Scenario.fromMove(List <Tube> tubes, this.tubePop, this.tubePush) {
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      Tube newTube = Tube();
      Tube oldTube = tubes[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        int ball = oldTube.content[slot];
        newTube.content.add(ball);
      }
      content.add(newTube);
    }
  }

  bool get isValid {

    if(content.length != (maxColors + extraTubes) ){
      return false;
    }
    Map <int, int> eachColorAmount = <int, int>{};
    for(Tube tube in content) {
      for(int ball in tube.content) {
        if(eachColorAmount.containsKey(ball)){
          int oldAmount = eachColorAmount[ball]!;
          eachColorAmount[ball] = oldAmount + 1;
        } else {
          eachColorAmount[ball] = 1;
        }
      }
    }
    bool allValids = true;
    if(eachColorAmount.isEmpty) {
      //Caso colores repetidos en demasia
      print("eachColorAmount esta vacio" );
    }
    eachColorAmount.forEach((int key, int value) {
      int amount = eachColorAmount[key]!;
      allValids = allValids & (amount == maxSpaces);
      if(amount != maxSpaces) {
        print("key " +key.toString());
        print("actual  " + amount.toString());
        print("expected " + maxSpaces.toString());
      }
    });
    return allValids;
  }

  bool get isFinish {
    bool allValids = true;
    for(Tube tube in content) {
      allValids = allValids & (tube.areAllBallsTheSameColour);
    }
    return allValids;
  }

  @override
  String toString() => content.toString();

  bool move(int _tubePop, int _tubePush) {
    Tube tubePop = content[_tubePop];
    Tube tubePush = content[_tubePush];

    if(tubePop.isEmpty || tubePush.isFull) {
      return false;
    }
    if(tubePush.isNotEmpty && tubePop.topColor != tubePush.topColor) {
      return false;
    }
    int ball = tubePop.pop()!;
    tubePush.push(ball);
    return true;
  }

  int getHeuristic() {
    int total = 0;
    for(int tube = 0; tube < (maxColors); tube++) {
      total += content[tube].getHeuristic();
    }
    return total;
  }

  /*
  Scenario reColorScenarioForStoring() {
    Scenario original = this;
    Scenario perfect = Scenario.fromList(content);
    perfect.content.sort((a, b) { return a.compareTo(b); });
    int newColor = 1;
    Map<int,int> recolor =  <int, int>{};
    //TODO no se cual es el algoritmo para llevar los coloeres a un
    //TODO  standar y no repetir scenarios
    return perfect;
  }*/

  Scenario? fromMove(int _tubePop, int _tubePush) {
    Tube tubePop = content[_tubePop];
    Tube tubePush = content[_tubePush];

    if(tubePop.isEmpty || tubePush.isFull) {
      return null;
    }
    if(tubePush.isNotEmpty && tubePop.topColor != tubePush.topColor) {
      return null;
    }
    Scenario newScenario = Scenario.fromMove(content, _tubePop, _tubePush);
    newScenario.move(_tubePop, _tubePush);

    return newScenario;
  }

  @override
  bool operator ==(Object other) {
    if(  other is Scenario && other.runtimeType == runtimeType ) {

      Scenario thisOrdeted = Scenario.fromList(content);
      thisOrdeted.content.sort((a, b) { return a.compareTo(b); });

      Scenario otherOrdeted = Scenario.fromList(other.content);
      otherOrdeted.content.sort((a, b) { return a.compareTo(b); });

      for(int tube = 0; tube < content.length; tube++) {
        if(thisOrdeted.content[tube] != otherOrdeted.content[tube]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode {
    Scenario thisOrdeted = Scenario.fromList(content);
    thisOrdeted.content.sort((a, b) { return a.compareTo(b); });
    int hash = Object.hashAll(thisOrdeted.content);
    return hash;
  }

  int compareTo(Scenario other) {
    int thisHeuristic = getHeuristic();
    int otherHeuristic = other.getHeuristic();
    if(thisHeuristic < otherHeuristic ) {
      //logica invertida
      //soy más importante
      return 1;//return -1;
    }
    if(thisHeuristic > otherHeuristic ) {
      //logica invertida
      return -1;//return 1;
    }
    //la misma heuristica
    return 0;
  }

  List<int> getMove(){
    return [ tubePop, tubePush];
  }

}