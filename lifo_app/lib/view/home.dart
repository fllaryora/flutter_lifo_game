import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/view/material_helper.dart';
import 'package:lifo_app/view/numeral_text_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tubesAmount = 4;
  TextEditingController nameController = TextEditingController(text: '4');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfffffaeb),
      appBar: AppBar(title: Text(widget.title),),
      body: Center(

        child: Column(
          //start == top
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10.0,
                  left: 20.0, right: 20.0),
              child: Text(
                'How many items there are in a single tube?',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 28,
                    color: Color(0xff9d916b)
                  )
              ),
            ),
            NumberInput(
              label: 'Items per tube ',
              hint: 'How many balls it has?',
              controller: nameController,
              onChanged: (text) {
                int? possibleNull = int.tryParse(text);
                if(possibleNull != null){
                  setState(() {
                    _tubesAmount = possibleNull;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}