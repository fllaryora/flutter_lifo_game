import 'dart:math';

import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/view/model/pair_ball.dart';

class TubeView {
  final content = <PairBall>[];

  TubeView();

  TubeView.fromList(List <PairBall> tube) {
    for(int slot = 0; slot < tube.length; slot++) {
      content.add(tube[slot]);
    }
  }

  @override
  bool operator ==(Object other) {
    if(  other is TubeView && other.runtimeType == runtimeType &&
        other.content.length == content.length) {
        for(int slot = 0; slot < content.length; slot++) {
          if(content[slot].colorIndex != other.content[slot].colorIndex) {
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

  int? get baseColor => content.isEmpty? null:content.first.colorIndex;
  int? get topColor => content.isEmpty? null:content.last.colorIndex;

  @override
  String toString() => content.toString();

  PairBall? pop() {
    if(isNotEmpty){
      return content.removeLast();
    } else {
      return null;
    }
  }

  bool push(PairBall ball) {
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
    int lastBall = content.first.colorIndex;
    for(PairBall ball in content) {
      if(lastBall != ball.colorIndex) {
        return false;
      }
    }
    return true;
  }

  bool sameColour(int maxIndex) {
    if(isEmpty) {
      return true;
    }
    int lastBall = content.first.colorIndex;
    for(int slot = 0; slot < maxIndex; slot++) {
      int ball = content[slot].colorIndex;
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

  bool humanPush(PairBall ball) {
    /* en el tubo el fist es la base del tubo*/
    /* en el tubo el last es la boca del tubo*/
    if(isEmpty || content.last == ball) {
      return push(ball);
    }
    return false;
  }

  int compareTo(TubeView other) {
      if(content.length < other.length ) {
        return -1;
      }
      if(content.length > other.length ) {
        return 1;
      }
      // tienen la misma cantidad de bolas
      for(int slot = 0; slot < content.length; slot++) {
        int color = content[slot].colorIndex;
        int otherColor = other.content[slot].colorIndex;
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



