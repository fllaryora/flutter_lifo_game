import 'package:flutter/material.dart';

class TubeSolver extends StatelessWidget {

  const TubeSolver({super.key, required this.left,
  required this.top,
  required this.tubeWidth, required this.tubeHeight});
  final double left;
  final double top;
  final double tubeWidth;
  final double tubeHeight;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top ,
      child: Card(
        elevation: 0.0,
        color: Colors.grey.shade100,
        shape:  RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(tubeWidth),
              bottomRight: Radius.circular(tubeWidth)),
        ),
        child: SizedBox(
          width: tubeWidth,
          height: tubeHeight,
        ),
      ),
    );
  }

}