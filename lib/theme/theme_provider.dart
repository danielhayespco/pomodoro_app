import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'button_styles.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_darkTheme);

  static final ThemeData _darkTheme = ThemeData(
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

  void setThemeColor(Color color) {
    state = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(color),
      ).copyWith(
        secondary: color,
        background: AppColors.background,
      ),
      textTheme: TextTheme(
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        labelLarge: AppTextStyles.labelLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyles.elevatedButtonStyle(color),
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  Color get currentColor => state.colorScheme.secondary;
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1),
  });
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
