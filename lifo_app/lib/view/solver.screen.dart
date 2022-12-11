import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/helpers/draw_balls.dart';
import 'package:lifo_app/view/helpers/draw_tubes.dart';
import 'package:lifo_app/view/subwidgets/tube.solve.dart';

class SolverPage extends StatefulWidget {
  const SolverPage({super.key, required this.title,
  required this.solution});
  final String title;
  final List<Scenario> solution;

  @override
  State<SolverPage> createState() => _SolverPageState();
}

class _SolverPageState extends State<SolverPage> {


  @override
  void initState() {

    super.initState();
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    int tubeAmount = 18;
    int itemPerTube = 6;//4 normal//7 alto

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = min(width, height) * 0.1;
    double stackWidth = width;
    double stackHeight = height * 0.67;
    return Scaffold(
      backgroundColor: const Color(0xfffffaeb),
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
            //start == top
            mainAxisAlignment: MainAxisAlignment.start,
            //start == leading / left
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ratio/4.0,
                    left: ratio/2.0, right: ratio/2.0),
                child: const Text(
                  'Solution',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 55,
                        fontFamily: 'Misteryzero',
                      color: Color(0xff9d916b)
                    )
                ),
              ),
              Container(
                color: Colors.deepOrangeAccent,
                child: SizedBox(
                  width: width,
                  height: stackHeight,
                  child: Stack(
                    children: drawScenario(stackHeight, stackWidth,
                        ratio, tubeAmount, itemPerTube),
                  ),
                ),
              ),
              SizedBox(
                height: ratio/4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.blueGrey.shade300,
                    borderRadius: BorderRadius.circular(ratio*2.5),
                    child: InkWell(
                      onTap: () {
                      },
                      borderRadius: BorderRadius.circular(ratio*2.5),
                      child: Container(
                        width: ratio * 4.0,
                        height: ratio,
                        alignment: Alignment.center,
                        child: const Text('Prev',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ratio/2,
                  ),
                  Material(
                    color: Colors.blueGrey.shade300,
                    borderRadius: BorderRadius.circular(ratio*2.5),
                    child: InkWell(
                      onTap: () {
                      },
                      borderRadius: BorderRadius.circular(ratio*2.5),
                      child: Container(
                        width: ratio * 4.0,
                        height: ratio,
                        alignment: Alignment.center,
                        child: const Text('Next',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
    );
  }

  List<Widget> drawScenario(
      double stackHeight, double stackWidth, double ratio,
       int tubeAmount, int itemsPerTube) {

    double tubeRatio = getTubeRatio( ratio, tubeAmount, itemsPerTube);
    double tubeWidth = tubeRatio;
    double tubeHeight = tubeRatio * itemsPerTube;

    List<Widget> items = drawTubes(stackHeight, stackWidth,
         tubeWidth, tubeHeight, tubeAmount, itemsPerTube);

    items.addAll(drawBalls(
         stackHeight,  stackWidth, tubeRatio,
         tubeWidth, tubeHeight, tubeAmount, itemsPerTube));
    return items;
  }

}