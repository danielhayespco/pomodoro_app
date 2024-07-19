import 'package:flutter/material.dart';

class AppButtonStyles {
  static ButtonStyle elevatedButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  static const double buttonHeight = 48.0;
  static const double buttonWidth = 120.0;

  static const double rowHeight = 63.0;
  static const double rowMinWidth = 327.0;
}
