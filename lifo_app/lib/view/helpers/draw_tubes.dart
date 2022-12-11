import 'package:flutter/material.dart';
import 'package:lifo_app/view/subwidgets/tube.solve.dart';

List<Widget> drawTubes(
    double stackHeight, double stackWidth,double ratio,
    double tubeWidth, double tubeHeight, int amount) {

  int internalTubes = amount;
  bool extraRow = (internalTubes % 8) > 0;
  List<Widget> tubes = <Widget>[];
  //integer division
  int rows = internalTubes ~/8;
  if(extraRow){
    rows = rows + 1;
  }
  //Estos factores corrigen el descentradode las cards
  double minusFactorH = 2.0;
  double minusFactorW = 2.0;
  if(rows == 3){
    minusFactorH = 1.85;
    minusFactorW = 1.6;
  }
  if(rows == 2){
    minusFactorH = 1.87;
    minusFactorW = 1.65;
  }
  if(rows == 1){
    minusFactorH = 1.9;
    minusFactorW = 1.7;
  }
  for(int indexRow = 1; indexRow < (rows+1) ;indexRow++) {
    double factor = indexRow.toDouble() / (rows+1).toDouble();
    double tubeTop = (stackHeight * factor) - (tubeHeight/minusFactorH);
    int columns = internalTubes;
    internalTubes = internalTubes - 8;
    if(internalTubes > 0) {
      columns = 8;
    }
    for(int indexColumn = 1; indexColumn < (columns+1) ;indexColumn++) {
      double factor = indexColumn.toDouble() / (columns+1).toDouble();
      double tubeLeft = (stackWidth * factor) - (tubeWidth /minusFactorW);
      tubes.add(
        TubeSolver(left: tubeLeft,top: tubeTop,
            ratio: ratio, tubeWidth: tubeWidth,
            tubeHeight: tubeHeight),
      );
    }
  }
  return tubes;
}