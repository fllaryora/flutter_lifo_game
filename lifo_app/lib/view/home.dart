import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/view/consigna_text.dart';
import 'package:lifo_app/view/material_helper.dart';
import 'package:lifo_app/view/numeral_text_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemsPerTube = 4;
  TextEditingController itemController = TextEditingController(text: '4');
  int _extraTubes = 2;
  TextEditingController extrasController = TextEditingController(text: '2');
  int _amountOfcolors = 10;
  TextEditingController colorsController = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfffffaeb),
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //start == top
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10.0,
                    left: 20.0, right: 20.0),
                child: Text(
                  'Settings',
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
                onChanged: (text) {
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
                onChanged: (text) {
                  int? possibleNull = int.tryParse(text);
                  if(possibleNull != null){
                    setState(() {
                      _amountOfcolors = possibleNull;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}