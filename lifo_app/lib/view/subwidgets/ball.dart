import 'dart:math';

import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  Ball({super.key, required this.amount,
  required this.initialColorIndex, required this.onChanged});
  final int amount;
  final int initialColorIndex;
  late BallState currentState;
  final Function onChanged;
  @override
  State<Ball> createState() => BallState();

}

class BallState extends State<Ball> {

  late int currentColorIndex ;
  late int maxIndex ;
  @override
  void initState() {
    currentColorIndex = widget.initialColorIndex;
    maxIndex = widget.amount-1;
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
    return colorsList[currentColorIndex];
  }

  void cycleColor(){
    currentColorIndex = currentColorIndex + 1;
      if(currentColorIndex > maxIndex) {
        currentColorIndex = 0;
      }
      setState(() {
        currentColorIndex = currentColorIndex;
      });
      widget.onChanged(currentColorIndex);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = min(width, height)*0.1;
    return Container(
        padding: EdgeInsets.all(ratio/8.0),
        child: Material(
          color: getColor(),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              cycleColor();
            },
            child: SizedBox(
              width: ratio,
              height: ratio,
            ),
          ),
        ),
    );
  }
}