import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/domain/a_star.dart';
import 'package:lifo_app/view/solver.screen.dart';
import 'package:lifo_app/view/subwidgets/tube.dart';

import '../data/model/balls.dart';

class ConfigurePage extends StatefulWidget {
  ConfigurePage({super.key, required this.title,
  required this.itemsPerTube, required this.amountOfColors,
  required this.extraTubesToUse});
  final String title;
  final int itemsPerTube;
  final int amountOfColors;
  final int extraTubesToUse;

  late ConfigurePageState myState;

  @override
  State<ConfigurePage> createState() {
    myState = ConfigurePageState();
    return myState;
  }

  Scenario getScenario() {
    return Scenario.fromColors(myState.tubes);
  }
}

class ConfigurePageState extends State<ConfigurePage> {

  late List<List<int>> tubes;
  List<Scenario>? solution;
  @override
  void initState() {
    tubes = <List<int>>[];
    List<Balls> bolas = Balls.values;
    Random random = Random(87);
    for(int tubeIndex = 0; tubeIndex < widget.amountOfColors; tubeIndex++) {
      List<int> temporal = <int>[];
      for(int ballIndex = 0; ballIndex < widget.itemsPerTube; ballIndex++) {
        int indexColor = random.nextInt(widget.amountOfColors);
        Balls bola = bolas[indexColor + 1];
        print("Agrego bola" + bola.name);
        temporal.add(indexColor);
      }
      tubes.add(temporal);
    }
    for(int tubeIndex = 0; tubeIndex < widget.extraTubesToUse; tubeIndex++) {
      tubes.add(<int>[]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("amountOfColors: " + widget.amountOfColors.toString());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = min(width, height)*0.05;
    // double ratio = min(width, height)*0.1;
    double tubeHeight = widget.itemsPerTube * ratio * 2.5  + widget.itemsPerTube * (ratio/5);

    //(widget.itemsPerTube * 58 - (widget.itemsPerTube-1) * 3)
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
                  padding: EdgeInsets.only(top: ratio/4.0, bottom: ratio/4.0,
                      left: ratio/2.0, right: ratio/2.0),
                  child: const Text(
                    'Configure',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal,
                          fontSize: 55,
                          fontFamily: 'Misteryzero',
                        color: Color(0xff9d916b)
                      )
                  ),
                ),
                SizedBox(
                  height: ratio,
                ),
                const Text(
                    'Tap the balls inside the tubes to configure the game.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 25,
                        color: Color(0xff9d916b)
                    )
                ),
                SizedBox(
                  height: ratio,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: ratio/2.0),
                  height: tubeHeight,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: getTubes(),
                    ),
                  ),
                ),
                SizedBox(
                  height: ratio,
                ),
                Material(
                  color: Colors.blueGrey.shade300,
                  borderRadius: BorderRadius.circular(ratio*2.5),
                  child: InkWell(
                    key: const Key('validate'),
                    onTap: () {
                      Scenario scenarioToExperiment = Scenario.fromColors(
                          tubes
                      );

                      print(scenarioToExperiment);
                      if(! scenarioToExperiment.isValid ) {
                        _displayDialog(context, 'The scenario is not valid');
                        return;
                      } else {
                        //_displayDialog(context, 'VALID');
                        if(mounted) {
                          solver(scenarioToExperiment);
                        }

                      }

                    },
                    borderRadius: BorderRadius.circular(ratio*2.5),
                    child: Container(
                      width: ratio*2.5*4.0,
                      height: ratio*2.5,
                      alignment: Alignment.center,
                      child: const Text('Validate',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ratio,
                ),
              ],
            ),
      ),
    );
  }

  List<Widget> getTubes() {
    List<Widget> tubesW = <Widget>[];
    for(int tubeIndex = 0; tubeIndex < widget.amountOfColors; tubeIndex++) {
      tubesW.add (TubeComponent(amountOfColors: widget.amountOfColors,
          itemsPerTube: widget.itemsPerTube, initialTube: tubes[tubeIndex]));
    }
    return tubesW;
  }

  Future<void> _displayDialog(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  Future<void> solver(Scenario scenarioToExperiment) async {
    AStarSearch aStart = AStarSearch(scenarioToExperiment);
    solution = aStart.solve();
    if(!mounted) {
      return;
    }
    if(solution != null) {
      //_displayDialog(context, 'The SOLUTION was found');
      Navigator.push(
        context,
        MaterialPageRoute( builder: (context) =>
            SolverPage(title: widget.title, solution: solution!)
        )
      );
    } else {
      _displayDialog(context, 'No SOLUTION was found');
    }
    return;
  }

}