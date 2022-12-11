import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifo_app/view/subwidgets/tube.solve.dart';

double getTubeRatio(double ratio,
    int tubeAmount, int itemPerTube) {
  double tubeRatio =  ratio;
  if(tubeAmount > 8) {
    switch( itemPerTube) {
      case 5:
        tubeRatio = ratio * 0.8;
        break;
      case 6:
        tubeRatio = ratio * 0.65;
        break;
      case 7:
        tubeRatio = ratio * 0.55;
        break;
    }
    tubeRatio = tubeRatio * 0.9;
  }
  if(tubeAmount > 16) {
    switch( itemPerTube) {
      case 5:
        tubeRatio = ratio * 0.8;
        break;
      case 6:
        tubeRatio = ratio * 0.65;
        break;
      case 7:
        tubeRatio = ratio * 0.55;
        break;
    }
    tubeRatio = tubeRatio * 0.65;
  }
  return tubeRatio;
}

List<Widget> drawTubes(
    double stackHeight, double stackWidth,
    double tubeWidth, double tubeHeight, int amountOfTubes, int itemsPerTube) {

  int internalTubes = amountOfTubes;
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
    switch(itemsPerTube){
      case 5:
        minusFactorW = 1.5;
        break;
      case 6:
        minusFactorW = 1.4;
        break;
      case 7:
        minusFactorW = 1.39;
        break;
    }
  }
  if(rows == 2){
    minusFactorH = 1.87;
    minusFactorW = 1.65;
    switch(itemsPerTube){
      case 5:
        minusFactorW = 1.63;
        break;
      case 6:
        minusFactorW = 1.59;
        break;
      case 7:
        minusFactorW = 1.53;
        break;
    }
  }
  if(rows == 1){
    minusFactorH = 1.91;
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
            tubeWidth: tubeWidth,
            tubeHeight: tubeHeight),
      );
    }
  }
  return tubes;
}
