
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/model/TubeView.dart';
import 'package:lifo_app/view/model/pair_ball.dart';

class ScenarioView {
  final List<TubeView> content = <TubeView>[];

  ScenarioView.fromList(List <TubeView> tubes) {
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      TubeView newTube = TubeView();
      TubeView oldTube = tubes[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        PairBall ball = oldTube.content[slot];
        newTube.content.add(ball);
      }
      content.add(newTube);
    }
  }

  ScenarioView.fromColors(List <List<PairBall>> listOfColors) {
    //print("maxColors + extraTubes " + (maxColors + extraTubes).toString());
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      TubeView newTube = TubeView();
      List<PairBall> oldTube = listOfColors[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        PairBall ball = oldTube[slot];
        newTube.content.add(ball);
      }
      content.add(newTube);
    }
  }
  int tubePop = 0;
  int tubePush = 0;
  ScenarioView.fromMove(List <TubeView> tubes, this.tubePop, this.tubePush) {
    for(int tube = 0; tube < (maxColors + extraTubes); tube++) {
      //in maxspaces all tubes must be full
      //or get the exception
      TubeView newTube = TubeView();
      TubeView oldTube = tubes[tube];
      for(int slot = 0; slot < (oldTube.length); slot++) {
        PairBall ball = oldTube.content[slot];
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
    for(TubeView tube in content) {
      for(PairBall ball in tube.content) {
        if(eachColorAmount.containsKey(ball.colorIndex)){
          int oldAmount = eachColorAmount[ball.colorIndex]!;
          eachColorAmount[ball.colorIndex] = oldAmount + 1;
        } else {
          eachColorAmount[ball.colorIndex] = 1;
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
    for(TubeView tube in content) {
      allValids = allValids & (tube.areAllBallsTheSameColour);
      //BUGFIX : all the balls are the same color but rest the final moves
      allValids = allValids & (tube.isFull | tube.isEmpty);
    }
    return allValids;
  }

  @override
  String toString() => content.toString();

  bool move(int _tubePop, int _tubePush) {
    TubeView tubePop = content[_tubePop];
    TubeView tubePush = content[_tubePush];

    if(tubePop.isEmpty || tubePush.isFull) {
      return false;
    }
    if(tubePush.isNotEmpty && tubePop.topColor != tubePush.topColor) {
      return false;
    }
    PairBall ball = tubePop.pop()!;
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

  ScenarioView? fromMove(int _tubePop, int _tubePush) {
    TubeView tubePop = content[_tubePop];
    TubeView tubePush = content[_tubePush];

    if(tubePop.isEmpty || tubePush.isFull) {
      return null;
    }
    if(tubePush.isNotEmpty && tubePop.topColor != tubePush.topColor) {
      return null;
    }
    ScenarioView newScenario = ScenarioView.fromMove(content, _tubePop, _tubePush);
    newScenario.move(_tubePop, _tubePush);

    return newScenario;
  }

  @override
  bool operator ==(Object other) {
    if(  other is ScenarioView && other.runtimeType == runtimeType ) {

      ScenarioView thisOrdeted = ScenarioView.fromList(content);
      thisOrdeted.content.sort((a, b) { return a.compareTo(b); });

      ScenarioView otherOrdeted = ScenarioView.fromList(other.content);
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
    ScenarioView thisOrdeted = ScenarioView.fromList(content);
    thisOrdeted.content.sort((a, b) { return a.compareTo(b); });
    int hash = Object.hashAll(thisOrdeted.content);
    return hash;
  }

  int compareTo(ScenarioView other) {
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