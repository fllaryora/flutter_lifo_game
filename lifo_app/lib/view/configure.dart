import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/subwidgets/ball.dart';
import 'package:lifo_app/view/subwidgets/consigna_text.dart';
import 'package:lifo_app/view/subwidgets/numeral_text_field.dart';

class ConfigurePage extends StatefulWidget {
  const ConfigurePage({super.key, required this.title,
  required this.itemsPerTube, required this.amountOfColors,
  required this.extraTubesToUse});
  final String title;
  final int itemsPerTube;
  final int amountOfColors;
  final int extraTubesToUse;
  @override
  State<ConfigurePage> createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {

  @override
  Widget build(BuildContext context) {
    print("amountOfColors: " + widget.amountOfColors.toString());

    List<Tube> tubes =
      List.filled(widget.amountOfColors + widget.extraTubesToUse, Tube());
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
                height: 210.0, //210 son 4 tubos
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    //your widget items here
                    //El tubo es esto
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                        ),
                        child: Column(
                          children: [
                            //Ball( amount: widget.amountOfColors,),
                            //Ball( amount: widget.amountOfColors,),
                            //Ball( amount: widget.amountOfColors,),
                            Ball( amount: widget.amountOfColors,),
                          ],
                        ),
                      ),
                    )
                  ],
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
                    child: const Text('Next',
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
}