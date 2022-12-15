import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/view/helpers/draw_balls.dart';
import 'package:lifo_app/view/helpers/draw_tubes.dart';
import 'package:lifo_app/view/model/TubeView.dart';
import 'package:lifo_app/view/model/scenarioView.dart';

class SolverPage extends StatefulWidget {
  const SolverPage({super.key, required this.title,
  required this.solution});
  final String title;
  final List<ScenarioView> solution;

  @override
  State<SolverPage> createState() => _SolverPageState();
}

class _SolverPageState extends State<SolverPage> {

  late int itemPerTube;
  late int currentScenario;
  late ScenarioView thisScenaro;

  @override
  void initState() {
    itemPerTube = maxSpaces;
    currentScenario = 0;
    super.initState();
  }

  bool selected = false;
  String moveDescription ="";
  @override
  Widget build(BuildContext context) {
    thisScenaro = widget.solution[currentScenario];
    createDescription();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = min(width, height) * 0.1;
    double stackWidth = width;
    double stackHeight = height * 0.67;
    return Scaffold(
      backgroundColor: const Color(0xfffffaeb),
      appBar: AppBar(title: Text(widget.title),),
      body: SingleChildScrollView(
        child: Column(
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
                Padding(
                  padding: EdgeInsets.only(left: ratio/2.0, right: ratio/2.0),
                  child: Text(
                      moveDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Color(0xff9d916b)
                      )
                  ),
                ),
                SizedBox(
                  height: ratio/4,
                ),
                Container(
                  //color: Colors.deepOrangeAccent,
                  child: SizedBox(
                    width: width,
                    height: stackHeight,
                    child: Stack(
                      children: drawScenario(stackHeight, stackWidth,
                          ratio),
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
                          if(currentScenario > 0){
                            setState(() {
                              currentScenario = currentScenario - 1;
                            });
                          }
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
                          if( isNextScenario() ) {
                            setState(() {
                              currentScenario = currentScenario + 1;
                            });
                          }
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
                ),
                SizedBox(
                  height: ratio/4,
                ),
              ],
            ),
      ),
    );
  }

  void createDescription() {

    if(thisScenaro.isFinish) {
      moveDescription = "All the balls are sorted.";
    } else {
      if(isNextScenario()) {
        ScenarioView nextScenaro = widget.solution[currentScenario+1];
        List<int> nextMove = nextScenaro.getMove();
        int tubeIndex = nextMove[1];
        TubeView tubeDest = nextScenaro.content[tubeIndex];
        int color = tubeDest.topColor!;
        List<Balls> bolas = Balls.values;
        Balls bola = bolas[color];
        moveDescription = "Move the ${bola.name.toLowerCase()} ball from tube"
            " ${(nextMove[0] + 1).toString()} to tube ${(nextMove[1] + 1).toString()}";
      }
    }
  }

  bool isNextScenario() => currentScenario < (widget.solution.length - 1);


  List<Widget> drawScenario(
      double stackHeight, double stackWidth, double ratio) {

    double tubeRatio = getTubeRatio(ratio);
    double tubeWidth = tubeRatio;
    double tubeHeight = tubeRatio * itemPerTube;
    List<Widget> items = drawTubes(
        stackHeight, stackWidth,
         tubeWidth, tubeHeight);


    items.addAll(drawBalls(
         stackHeight,  stackWidth, tubeRatio,
         tubeWidth, tubeHeight, thisScenaro));
    return items;
  }

}