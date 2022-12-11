import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/scenario.dart';
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
    int tubeAmount = 15;
    int itemPerTube = 4;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //Depende de la cantidad de pelotas
    double ratio = min(width, height)*0.1; //tamanyo de las pelotas

    double stackWidth = width;
    double stackHeight = height * 0.55;
    double tubeWidth = ratio;
    double tubeHeight = ratio * itemPerTube + ratio * 0.6;

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
                padding: EdgeInsets.only(top: ratio/4.0, bottom: ratio/4.0,
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
                    children: drawTubes(stackHeight, stackWidth,
                        ratio, tubeWidth, tubeHeight, tubeAmount),
                    /*<Widget>[
                      TubeSolver(left: tubeLeft,top: tubeTop,
                          ratio: ratio, tubeWidth: tubeWidth,
                          tubeHeight: tubeHeight),

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
              )
            ],
          ),
    );
  }

  List<Widget> drawTubes(
      double stackHeight, double stackWidth,double ratio,
      double tubeWidth, double tubeHeight, int amount) {

    int internalTubes = amount;
    bool extraRow = (internalTubes % 8) > 0;
    List<Widget> tubes = <Widget>[];
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
          TubeSolver(left: tubeLeft,top: tubeTop,
              ratio: ratio, tubeWidth: tubeWidth,
              tubeHeight: tubeHeight),
        );
      }
    }
    return tubes;
  }
}