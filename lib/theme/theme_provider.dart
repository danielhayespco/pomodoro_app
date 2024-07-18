import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'button_styles.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_darkTheme);

  String _fontFamily = 'KumbhSans';
  Color _selectedColor = const Color(0xFFF87070);

  static final ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: generateMaterialColor(const Color(0xFFF87070)),
    ).copyWith(
      secondary: const Color(0xFFF87070),
      background: AppColors.background,
    ),
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.body1.copyWith(fontFamily: 'KumbhSans'),
      bodyMedium: AppTextStyles.body2.copyWith(fontFamily: 'KumbhSans'),
      headlineLarge: AppTextStyles.h2.copyWith(fontFamily: 'KumbhSans'),
      headlineMedium: AppTextStyles.h3.copyWith(fontFamily: 'KumbhSans'),
      headlineSmall: AppTextStyles.h4.copyWith(fontFamily: 'KumbhSans'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonStyles.elevatedButtonStyle(const Color(0xFFF87070)),
    ),
    scaffoldBackgroundColor: AppColors.background,
  );

  void setThemeColor(Color color) {
    _selectedColor = color;
    _updateTheme();
  }

  void setFontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    _updateTheme();
  }

  void _updateTheme() {
    state = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(_selectedColor),
      ).copyWith(
        secondary: _selectedColor,
        background: AppColors.background,
      ),
      textTheme: TextTheme(
        bodyLarge: AppTextStyles.body1.copyWith(fontFamily: _fontFamily),
        bodyMedium: AppTextStyles.body2.copyWith(fontFamily: _fontFamily),
        headlineLarge: AppTextStyles.h2.copyWith(fontFamily: _fontFamily),
        headlineMedium: AppTextStyles.h3.copyWith(fontFamily: _fontFamily),
        headlineSmall: AppTextStyles.h4.copyWith(fontFamily: _fontFamily),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyles.elevatedButtonStyle(_selectedColor),
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  Color get currentColor => state.colorScheme.secondary;
  String get currentFontFamily => _fontFamily;
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
