import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/configure.dart';

import 'package:lifo_app/view/subwidgets/consigna_text.dart';
import 'package:lifo_app/view/subwidgets/numeral_text_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemsPerTube = 2;
  TextEditingController itemController = TextEditingController(text: '2');
  int _extraTubes = 2;
  TextEditingController extrasController = TextEditingController(text: '2');
  int _amountOfColors = 3;
  TextEditingController colorsController = TextEditingController(text: '3');

  final int MAX_EXTRA_TUBES = 6;
  final int  MAX_COLORS = 16;
  final int MAX_ITEMS_PER_TUBE = 8;

  final int MIN_EXTRA_TUBES = 1;
  final int MIN_COLORS = 1;
  final int MIN_ITEMS_PER_TUBE = 2;
  @override
  void dispose() {
    itemController.dispose();
    extrasController.dispose();
    colorsController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

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
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10.0,
                    left: 20.0, right: 20.0),
                child: Text(
                  'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 55,
                        fontFamily: 'Misteryzero',
                      color: Color(0xff9d916b)
                    )
                ),
              ),
              const MottoText(title: 'How many items there are in a single tube?',),
              NumberInput(
                label: 'Items per tube ',
                hint: 'How many balls it has?',
                controller: itemController,
                onChanged: (String text) {
                  int? possibleNull = int.tryParse(text);
                  if(possibleNull != null){
                    setState(() {
                      _itemsPerTube = possibleNull;
                    });
                  }
                },
              ),
              const MottoText(title: 'How many different ball colors should be have?',),
              NumberInput(
                label: 'Colors',
                hint: 'Amount of colors...',
                controller: colorsController,
                onChanged: (String text) {
                  int? possibleNull = int.tryParse(text);
                  if(possibleNull != null){
                    setState(() {
                      _amountOfColors = possibleNull;
                    });
                  }
                },
              ),
              const MottoText(title: 'How many extra tubes should be have?',),
              NumberInput(
                label: 'Colors',
                hint: 'Amount of colors...',
                controller: extrasController,
                onChanged: (String text) {
                  int? possibleNull = int.tryParse(text);
                  if(possibleNull != null){
                    setState(() {
                      _extraTubes = possibleNull;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Material(
                color: Colors.blueGrey.shade300,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: () {

                    if(_itemsPerTube >= MAX_ITEMS_PER_TUBE) {
                      _displayDialog(context, 'Item per tube must be less than $MAX_ITEMS_PER_TUBE');
                      return;
                    }

                    if(_amountOfColors >= MAX_COLORS) {
                      _displayDialog(context, 'Amount of colors must be less than $MAX_COLORS');
                      return;
                    }
                    if(_extraTubes >= MAX_EXTRA_TUBES) {
                      _displayDialog(context, 'Extra tubes must be less than $MAX_EXTRA_TUBES');
                      return;
                    }
                    if(_extraTubes <= MIN_EXTRA_TUBES ) {
                      _displayDialog(context, 'Extra tubes must be grater than $MIN_EXTRA_TUBES');
                      return;
                    }
                    if(_amountOfColors <= MIN_COLORS ) {
                      _displayDialog(context, 'Amount of colors must be grater than $MIN_COLORS');
                      return;
                    }
                    if(_itemsPerTube <= MIN_ITEMS_PER_TUBE ) {
                      _displayDialog(context, 'Item per tube must be grater than $MIN_ITEMS_PER_TUBE');
                      return;
                    }

                    maxColors = _amountOfColors;
                    maxSpaces = _itemsPerTube;
                    extraTubes = _extraTubes;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigurePage(title: widget.title,
                          itemsPerTube:_itemsPerTube,
                          amountOfColors: _amountOfColors,
                          extraTubesToUse: _extraTubes,
                      )),
                    );
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
        ),
    );
  }

  Future<void> _displayDialog(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextButton(onPressed: () {
               Navigator.of(context).pop();
             }, child:  Text('Ok'))
             ],
          );
        });
  }
}