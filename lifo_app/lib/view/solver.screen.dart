import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifo_app/data/model/scenario.dart';

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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double stackHeight = height * 0.55;
    double ratio = min(width, height)*0.1;
    double gap = ratio/4.0;
    double arriba = 0.0;
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
                //color: Colors.red,
                child: SizedBox(
                  width: width,
                  height: stackHeight,
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: <Widget>[

                      Positioned(
                        left: gap,
                        top: gap ,
                        child: Card(
                          color: Colors.grey.shade100,
                          shape:  RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(ratio),
                                bottomRight: Radius.circular(ratio)),
                          ),
                          child: SizedBox(
                            width: ratio,
                            height: ratio * 4 + ratio * 0.6,
                            ),
                        ),
                      ),

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
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }

}