import 'dart:math';
import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  Ball({super.key, required this.amount});
  final int amount;
  late BallState currentState;
  @override
  State<Ball> createState() {
    currentState =  BallState(amount-1);
    return currentState;
  }

  int getColor(){
    return currentState.getIndex();
  }
}

class BallState extends State<Ball> {
  late int index;
  late int maxIndex ;
  BallState(int _maxIndex) {
    maxIndex = _maxIndex;
    index = Random().nextInt(maxIndex);
    print("Index:" + index.toString());
  }

  int getIndex() {
    return index + 1;
  }

  List<Color> colorsList = [
    Colors.green.shade300,
    Colors.greenAccent.shade200,
    Colors.lightGreen.shade900,

    Colors.pink.shade100,
    Colors.red.shade300,
    Colors.yellow.shade200,
    Colors.deepOrangeAccent.shade200,

    Colors.lightBlue.shade100,
    Colors.blue.shade300,
    Colors.cyanAccent.shade200,
    Colors.indigo.shade200,
    Colors.purple.shade200,

    Colors.grey.shade700,
    Colors.black,
    Colors.white,
  ];

  Color getColor (int _index){
    return colorsList[_index];
  }

  void cycleColor(){
      int _index = index + 1;
      if(_index > maxIndex){
        _index = 0;
      }
      print("AAAAA index:" +index.toString());
      setState(() {
        index = _index;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: getColor(index),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              cycleColor();
            },
            child: const SizedBox(
              width: 40,
              height: 40,
            ),
          ),
        ),
    );
  }
}