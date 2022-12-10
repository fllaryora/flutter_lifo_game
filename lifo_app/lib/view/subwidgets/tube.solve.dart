import 'dart:math';

import 'package:flutter/material.dart';

class TubeSolver extends StatelessWidget {

  const TubeSolver({super.key, required this.left,
  required this.top, required this.ratio,
  required this.tubeWidth, required this.tubeHeight});
  final double left;
  final double top;
  final double ratio;
  final double tubeWidth;
  final double tubeHeight;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top ,
      child: Card(
        color: Colors.grey.shade100,
        shape:  RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(ratio),
              bottomRight: Radius.circular(ratio)),
        ),
        child: SizedBox(
          width: tubeWidth,
          height: tubeHeight,
        ),
      ),
    );
  }

}