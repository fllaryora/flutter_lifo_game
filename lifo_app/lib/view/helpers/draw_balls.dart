import 'package:flutter/material.dart';

List<Widget> drawBalls(
    double stackHeight, double stackWidth,double ratio,
    double tubeWidth, double tubeHeight, int amount, int itemsPerTube) {
  List<Widget> balls = <Widget>[];
  int internalTubes = amount;
  bool extraRow = (internalTubes % 8) > 0;

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
      balls.add(
        AnimatedPositioned(
          width: ratio,
          height: ratio,
          left: tubeLeft,
          top: tubeTop,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child:  Container(
            decoration: BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.circular(ratio)
            ),
          ),
        ),
      );
    }
  }
  return balls;
}