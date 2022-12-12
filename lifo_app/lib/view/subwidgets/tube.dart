import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/view/model/pair_ball.dart';
import 'package:lifo_app/view/subwidgets/ball.dart';

class TubeComponent extends StatefulWidget {
  TubeComponent({super.key, required this.amountOfColors,
  required this.itemsPerTube, required this.initialTube});
  final int amountOfColors;
  final int itemsPerTube;
  final List<PairBall> initialTube;
  late TubeState currentState;
  @override
  State<TubeComponent> createState() {
    currentState =  TubeState(amountOfColors, itemsPerTube);
    return currentState;
  }

}

class TubeState extends State<TubeComponent> {
  late int amountOfColors ;
  late int itemsPerTube;

  TubeState(int _amountOfColors, int _itemsPerTube) {
    amountOfColors = _amountOfColors;
    itemsPerTube = _itemsPerTube;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = min(width, height)*0.05;
    return Padding (
        padding: EdgeInsets.only(left: ratio/2.0,right: ratio/2.0),
        child: Card(
          color: Colors.grey.shade100,
          shape:  RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(ratio),
                bottomRight: Radius.circular(ratio)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getBalls(),
          ),
        ),
      );
  }

  List<Widget> getBalls() {
    List<Widget> ballsW = <Widget>[];
    for(int ballIndex = 0; ballIndex < itemsPerTube; ballIndex++) {
      //bugfix
      //prepend
      ballsW.insert(0, Ball( amount: amountOfColors,
          initialColorIndex: widget.initialTube[ballIndex],
          onChanged: (PairBall newIndexColor) {
            widget.initialTube[ballIndex] = newIndexColor;
          }));
    }
    return ballsW;
  }
}