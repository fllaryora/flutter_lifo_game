import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/scenario.dart';
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

    double tubeRatio = getTubeRatio( width, height, tubeAmount, itemPerTube);

    double tubeWidth = tubeRatio;
    double tubeHeight = tubeRatio * itemPerTube;

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
                    children: drawBalls(stackHeight, stackWidth,
                        tubeRatio, tubeWidth, tubeHeight,
                        tubeAmount, itemPerTube),
                    /*<Widget>[
                      AnimatedPositioned(
                        width: ratio,
                        height: ratio,
                        left: selected ? gap : 150.0,
                        top: selected ? gap : 150.0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = !selected;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.red,
                                borderRadius: BorderRadius.circular(ratio)
                            ),
                          ),
                        ),
                      ),
                    ],*/
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

  List<Widget> drawBalls(
      double stackHeight, double stackWidth,double ratio,
      double tubeWidth, double tubeHeight, int amount, int itemsPerTube) {
    List<Widget> tubes = drawTubes(stackHeight, stackWidth,
        ratio, tubeWidth, tubeHeight, amount, itemsPerTube);
    int internalTubes = amount;
    bool extraRow = (internalTubes % 8) > 0;

    //integer division
    int rows = internalTubes ~/8;
    if(extraRow){
      rows = rows + 1;
    }
    for(int indexRow = 1; indexRow < (rows+1) ;indexRow++) {
      double factor = indexRow.toDouble() / (rows+1).toDouble();
      double tubeTop = (stackHeight * factor) - (tubeHeight/2.0);
      int columns = internalTubes;
      internalTubes = internalTubes - 8;
      if(internalTubes > 0) {
        columns = 8;
      }
      for(int indexColumn = 1; indexColumn < (columns+1) ;indexColumn++) {
        double factor = indexColumn.toDouble() / (columns+1).toDouble();
        double tubeLeft = (stackWidth * factor) - (tubeWidth /2.0);
        tubes.add(
          AnimatedPositioned(
            width: ratio,
            height: ratio,
            left: tubeLeft,
            top: tubeTop,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child:  Container(
              decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(ratio)
              ),
            ),
          ),
        );
      }
    }
    return tubes;
  }
}