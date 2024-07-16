import 'package:flutter/material.dart';
import 'text_styles.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
  ).copyWith(
    secondary: const Color(0xFFF87070),
    background: const Color(0xFF1E213F),
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.body1,
    bodyMedium: AppTextStyles.body2,
    headlineLarge: AppTextStyles.h2,
    headlineMedium: AppTextStyles.h3,
    headlineSmall: AppTextStyles.h4,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF87070),
      textStyle: AppTextStyles.body1,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF1E213F),
);
