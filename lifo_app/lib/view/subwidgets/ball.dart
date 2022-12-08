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
      int color = currentColorIndex + 1;
      widget.onChanged(color);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.all(5),
        child: Material(
          color: getColor(),
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