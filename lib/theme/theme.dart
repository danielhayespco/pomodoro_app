import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'button_styles.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
  ).copyWith(
    secondary: AppColors.primary,
    background: AppColors.background,
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    headlineLarge: AppTextStyles.headlineLarge,
    labelLarge: AppTextStyles.labelLarge,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.elevatedButtonStyle(AppColors.primary),
  ),
  scaffoldBackgroundColor: AppColors.background,
);
