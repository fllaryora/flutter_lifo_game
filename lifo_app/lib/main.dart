import 'package:flutter/material.dart';
import 'package:lifo_app/view/home.dart';
import 'package:lifo_app/view/helpers/material_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(const Color(0xFFE1C699)),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary:const Color(0xFFE1C699),
              secondary: const Color(0xFFab9de1)),
      ),
      home: const MyHomePage(title: 'Lifo Solver'),
    );
  }
}
