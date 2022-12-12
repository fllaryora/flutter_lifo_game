import 'package:flutter/material.dart';

class PairBall {
  PairBall( this.colorIndex, this.key);
  int colorIndex;
  final String key;
  @override
  String toString() => 'Pair[$colorIndex, $key]';
}