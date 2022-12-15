import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/view/model/pair_ball.dart';

class Ball extends StatefulWidget {
  Ball({super.key, required this.amount,
  required this.initialColorIndex, required this.onChanged});
  final int amount;
  final PairBall initialColorIndex;
  late BallState currentState;
  final Function onChanged;
  @override
  State<Ball> createState() => BallState();

}

class BallState extends State<Ball> {

  late PairBall currentPairedColor ;
  late int maxIndex ;
  @override
  void initState() {
    currentPairedColor = widget.initialColorIndex;
    maxIndex = widget.amount-1;
    super.initState();
  }

  List<Color> colorsList = [
    Colors.red.shade300,//1
    Colors.yellow.shade200,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.pink.shade300,
    Colors.white,
    Colors.lightBlue.shade100,
    Colors.purple.shade200,//Colors.indigo.shade200,
    Colors.deepOrangeAccent.shade200,
    Colors.cyanAccent.shade200,
    Colors.greenAccent.shade200,
    Colors.grey.shade700,
    Colors.pink.shade100,
    Colors.lightGreen.shade900,
    Colors.black,//15
  ];

  Color getColor (){
    return colorsList[currentPairedColor.colorIndex];
  }

  Widget getColorWidgetList() {
    List<Widget> colorsListWidget = <Widget>[];
    List<String> colorNames = Balls.values.map((Balls ball) => ball.name.replaceAll("_", " ")).toList();
    for(int indexColor = 0 ; indexColor < colorsList.length; indexColor++) {
      Color color = colorsList[indexColor];
      String name = colorNames[indexColor];
      colorsListWidget.add(ListTile(
        leading: Icon(Icons.change_circle_rounded,color: color),
        title: Text(name),
        onTap: (){
          Navigator.pop(context, indexColor);
        },
      ));
    }
    return Wrap(
      children: colorsListWidget,
    );
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
            onTap: () async {
              int? nextColorIndex = await showModalBottomSheet<int>( isScrollControlled: true,
               // backgroundColor: colorOnPrimary,
                // set this when inner content overflows, making RoundedRectangleBorder not working as expected
                clipBehavior: Clip.antiAlias,
                // set shape to make top corners rounded
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: getColorWidgetList(),
                  );
                },);
              if(nextColorIndex != null){
                setState(() {
                  currentPairedColor.colorIndex = nextColorIndex;
                });
              }
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