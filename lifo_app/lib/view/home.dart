import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/view/material_helper.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10.0,
                left: 20.0, right: 20.0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Color(0xff786e9d), width: 5.0),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color:Color(0xff9d916b), width: 5.0),
                 ),
                hintText: 'How many balls it has?',
                labelText: 'Items per tube ',
                labelStyle: TextStyle(color: Color(0xff9d916b),
                    fontStyle: FontStyle.normal, fontSize: 20),
              ),
              onChanged: (text) {
                int? possibleNull = int.tryParse(text);
                if(possibleNull != null){
                  setState(() {
                    _tubesAmount = possibleNull;
                  });
                }
              },
            ),
          ),
          ],
        ),
      ),
    );
  }

}