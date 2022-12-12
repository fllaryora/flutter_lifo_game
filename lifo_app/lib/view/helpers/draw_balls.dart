import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/subwidgets/ball.solve.dart';
import 'package:lifo_app/view/subwidgets/ball.solve.fix.dart';

List<Widget> drawBalls(
    double stackHeight, double stackWidth,double ratio,
    double tubeWidth, double tubeHeight, Scenario sceneario) {
  List<Widget> balls = <Widget>[];
  int internalTubes = maxColors + extraTubes;
  int itemsPerTube = maxSpaces;
  bool extraRow = (internalTubes % 8) > 0;
  int tubeIndex = 0;
  //integer division
  int rows = internalTubes ~/8;
  if(extraRow){
    rows = rows + 1;
  }
  for(int indexRow = 1; indexRow < (rows+1) ;indexRow++) {
    double factor = indexRow.toDouble() / (rows+1).toDouble();
    double tubeTop = (stackHeight * factor) - (tubeHeight/2.0);
    int columns = internalTubes;
    internalTubes = internalTubes - 8;
    if(internalTubes > 0) {
      columns = 8;
    }
    for(int indexColumn = 1; indexColumn < (columns+1) ;indexColumn++) {
      double factor = indexColumn.toDouble() / (columns+1).toDouble();
      double tubeLeft = (stackWidth * factor) - (tubeWidth /2.0);
      Tube currentTube = sceneario.content[tubeIndex];
      useAnimatedBall(currentTube, itemsPerTube, balls, ratio, tubeLeft, tubeTop);
      tubeIndex++;
    }
  }
  return balls;
}

void useAnimatedBall(Tube currentTube, int itemsPerTube, List<Widget> balls, double ratio, double tubeLeft, double tubeTop) {
  if (currentTube.content.isNotEmpty) {
    int reversalIndex = itemsPerTube -1;
    for(int indexBall = 0; indexBall < currentTube.content.length; indexBall++) {
      int initialColorIndex = currentTube.content[indexBall];
      bool lastLoop = !((indexBall+1) < currentTube.content.length);
      if(lastLoop) {
        balls.add(
            BallSolve(ratio: ratio, initialColorIndex: initialColorIndex,
                tubeLeft: tubeLeft,
                tubeTop: tubeTop + (ratio * reversalIndex))
        );
      } else  {
        balls.add(
            BallSolveFixed(ratio: ratio, initialColorIndex: initialColorIndex,
                tubeLeft: tubeLeft,
                tubeTop: tubeTop + (ratio * reversalIndex))
        );
      }
      reversalIndex--;
    }
  }
}