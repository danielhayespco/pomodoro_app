import 'package:flutter/material.dart';

class AppButtonStyles {
  static ButtonStyle elevatedButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
