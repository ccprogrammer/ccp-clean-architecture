import 'package:flutter/material.dart';

class ColorServices {
  static Color colorFromHex<T>(
    String colorHex,
  ) {
    String regColor = colorHex.replaceAll(RegExp(r'#'), '');
    return Color(int.parse('0xFF$regColor'));
  }
}
