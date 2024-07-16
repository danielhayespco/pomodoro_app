import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
  ).copyWith(
    secondary: const Color(0xFFF87070),
    background: const Color(0xFF1E213F),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontFamily: 'KumbhSans', color: Colors.white),
    bodyMedium: TextStyle(fontFamily: 'RobotoSlab', color: Colors.white),
    headlineLarge: TextStyle(
      fontFamily: 'KumbhSans',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelLarge: TextStyle(fontFamily: 'RobotoSlab', color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurpleAccent,
      textStyle: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF1E213F),
);
