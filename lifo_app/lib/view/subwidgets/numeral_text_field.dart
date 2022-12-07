import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10.0,
          left: 20.0, right: 20.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff786e9d), width: 4.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:Color(0xff9d916b), width: 4.0),
          ),
          hintText: hint,
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xff9d916b),
              fontStyle: FontStyle.normal, fontSize: 20),
        ),
        onChanged: onChanged as void Function(String),
        style: const TextStyle(color: Color(0xff9d916b),
            fontStyle: FontStyle.normal, fontSize: 20),
      ),
    );
  }


}