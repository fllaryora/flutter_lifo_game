import 'dart:math';

int maxSpaces = 0;
/* en el tubo el fist es la base del tubo*/
/* en el tubo el last es la boca del tubo*/

// this is a fifo tube
class Tube  {
  final content = <int>[];

  Tube();

  Tube.fromList(List <int> tube) {
    for(int slot = 0; slot < tube.length; slot++) {
      int ball = tube[slot];
      content.add(ball);
    }
  }

  @override
  bool operator ==(Object other) {
    if(  other is Tube && other.runtimeType == runtimeType &&
        other.content.length == content.length) {
        for(int slot = 0; slot < content.length; slot++) {
          if(content[slot] != other.content[slot]) {
            return false;
          }
        }
        return true;
    }
    return false;
  }

  @override
  int get hashCode {
    int hash = Object.hashAll(content);
    return hash;
  }

  bool get isEmpty => content.isEmpty;
  bool get isNotEmpty => content.isNotEmpty;
  int get length => content.length;
  bool get isFull => content.length == maxSpaces;
  bool get isNotFull => content.length < maxSpaces;

  int? get baseColor => content.isEmpty? null:content.first;
  int? get topColor => content.isEmpty? null:content.last;

  @override
  String toString() => content.toString();

  int? pop() {
    if(isNotEmpty){
      return content.removeLast();
    } else {
      return null;
    }
  }

  bool push(int ball) {
    if(isNotFull) {
      content.add(ball);
      return true;
    }
    return false;
  }

  bool get areAllBallsTheSameColour {
    if(isEmpty) {
      return true;
    }
    int lastBall = content.first;
    for(int ball in content) {
      if(lastBall != ball) {
        return false;
      }
    }
    return true;
  }

  bool sameColour(int maxIndex) {
    if(isEmpty) {
      return true;
    }
    int lastBall = content.first;
    for(int slot = 0; slot < maxIndex; slot++) {
      int ball = content[slot];
      if(lastBall != ball) {
        return false;
      }
    }
    return true;
  }


  //forma no recursiva
  int getHeuristic() {
    if(isEmpty) {
      return 0;
    }
    int heuristic = 0;
    int maxIndex = length;
    while(maxIndex > 0) {
      //areAllBallsTheSameColour
      if(sameColour(maxIndex)) {
        heuristic += min(maxSpaces - (maxIndex), maxIndex);
        break;
      } else {
        heuristic++;
        maxIndex--;
      }
    }
    return heuristic;
  }

  bool humanPush(int ball) {
    /* en el tubo el fist es la base del tubo*/
    /* en el tubo el last es la boca del tubo*/
    if(isEmpty || content.last == ball) {
      return push(ball);
    }
    return false;
  }

  int compareTo(Tube other) {
      if(content.length < other.length ) {
        return -1;
      }
      if(content.length > other.length ) {
        return 1;
      }
      // tienen la misma cantidad de bolas
      for(int slot = 0; slot < content.length; slot++) {
        int color = content[slot];
        int otherColor = other.content[slot];
        if(color < otherColor ) {
          return -1;
        }
        if(color > otherColor ) {
          return 1;
        }
      }
      //las mismas bolas, los mismos colores
      return 0;
  }

}



