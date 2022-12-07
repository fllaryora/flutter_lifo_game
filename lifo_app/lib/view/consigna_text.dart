import 'package:flutter/material.dart';

class MottoText extends StatelessWidget {
  const MottoText({
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10.0,
          left: 20.0, right: 20.0),
      child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Color(0xff9d916b)
          )
      ),
    );
  }


}