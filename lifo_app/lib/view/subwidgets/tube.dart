import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/view/subwidgets/ball.dart';

class TubeComponent extends StatefulWidget {
  TubeComponent({super.key, required this.amountOfColors,
  required this.itemsPerTube, required this.onChanged});
  final int amountOfColors;
  final int itemsPerTube;
  final Function onChanged;
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
  late List<int> balls;
  TubeState(int _amountOfColors, int _itemsPerTube) {
    amountOfColors = _amountOfColors;
    itemsPerTube = _itemsPerTube;
    balls = List.filled(_itemsPerTube,
        Random().nextInt(amountOfColors - 1));
  }
  @override
  Widget build(BuildContext context) {
    return Padding (
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Card(
          color: Colors.grey.shade100,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
          child: Column(
            children: getBalls(),
          ),
        ),
      );
  }

  List<Widget> getBalls() {
    List<Widget> ballsW = <Widget>[];
    for(int ballIndex = 0; ballIndex < itemsPerTube; ballIndex++) {
      ballsW.add (Ball( amount: amountOfColors,
          initialColor:balls[ballIndex],
          onChanged: (int color) {
            balls[ballIndex] = color;
            widget.onChanged(balls);
          }));
    }
    return ballsW;
  }
}