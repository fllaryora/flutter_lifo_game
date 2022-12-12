import 'dart:math';

import 'package:flutter/material.dart';

class BallSolveFixed extends StatefulWidget {
  const BallSolveFixed({super.key, required this.ratio,
  required this.initialColorIndex, required this.tubeLeft,
  required this.tubeTop});

  final double ratio;
  final double  tubeLeft;
  final double tubeTop;
  final int initialColorIndex;
  @override
  State<BallSolveFixed> createState() => BallSolveFixedState();

}

class BallSolveFixedState extends State<BallSolveFixed> {

  @override
  void initState() {
    super.initState();
  }
  List<Color> colorsList = [
    Colors.red.shade300,//1
    Colors.yellow.shade200,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.purple.shade200,
    Colors.white,
    Colors.lightBlue.shade100,
    Colors.indigo.shade200,
    Colors.deepOrangeAccent.shade200,
    Colors.cyanAccent.shade200,
    Colors.greenAccent.shade200,
    Colors.grey.shade700,
    Colors.pink.shade100,
    Colors.lightGreen.shade900,
    Colors.black,//15
  ];

  Color getColor (){
    return colorsList[widget.initialColorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: widget.ratio,
      height: widget.ratio,
      left: widget.tubeLeft,
      top: widget.tubeTop,
      child:  Container(
        decoration: BoxDecoration(color: getColor(),
            borderRadius: BorderRadius.circular(widget.ratio)
        ),
      ),
    );
  }
}