import 'package:flutter/material.dart';

class Palette {
  // #3077FC
  static const primary = Colors.deepPurple;
  static final muted = Colors.grey.shade300;

  static final textLighter = Colors.grey.shade500;
  static final textLight = Colors.grey.shade600;
  static final text = Colors.grey.shade800;
  static final textDark = Colors.grey.shade900;
  static const textMuted = Colors.black26;
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff$color';
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  return int.parse(newColor);
}
