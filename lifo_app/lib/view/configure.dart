import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/subwidgets/ball.dart';
import 'package:lifo_app/view/subwidgets/tube.dart';

class ConfigurePage extends StatefulWidget {
  const ConfigurePage({super.key, required this.title,
  required this.itemsPerTube, required this.amountOfColors,
  required this.extraTubesToUse});
  final String title;
  final int itemsPerTube;
  final int amountOfColors;
  final int extraTubesToUse;
  @override
  State<ConfigurePage> createState() => _ConfigurePageState(amountOfColors);
}

class _ConfigurePageState extends State<ConfigurePage> {

  late List<List<int>> tubes;
  _ConfigurePageState(int amountOfColors){
    tubes = List.filled(amountOfColors, <int>[]);
  }

  @override
  Widget build(BuildContext context) {
    print("amountOfColors: " + widget.amountOfColors.toString());

    return Scaffold(
      backgroundColor: const Color(0xfffffaeb),
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
            //start == top
            mainAxisAlignment: MainAxisAlignment.start,
            //start == leading / left
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10.0,
                    left: 20.0, right: 20.0),
                child: Text(
                  'Configure',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 55,
                        fontFamily: 'Misteryzero',
                      color: Color(0xff9d916b)
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: (widget.itemsPerTube * 58 - (widget.itemsPerTube-1) * 3), //210 son 4 tubos
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getTubes(),
                ),
              ),
              Material(
                color: Colors.blueGrey.shade300,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: () {

                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text('Validate',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }
  List<Widget> getTubes() {
    List<Widget> tubesW = <Widget>[];
    for(int tubeIndex = 0; tubeIndex < widget.amountOfColors; tubeIndex++) {
      tubesW.add (TubeComponent(amountOfColors: widget.amountOfColors,
          itemsPerTube: widget.itemsPerTube,
          onChanged: (List<int> tube) {
            tubes[tubeIndex] = tube;
          }));
    }
    return tubesW;
  }
}