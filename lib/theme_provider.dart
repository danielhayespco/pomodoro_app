import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_darkTheme);

  static final ThemeData _darkTheme = ThemeData(
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
        backgroundColor: const Color(0xFFF87070),
        textStyle: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFF1E213F),
  );

  void setThemeColor(Color color) {
    state = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(color),
      ).copyWith(
        secondary: color,
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
          backgroundColor: color,
          textStyle: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF1E213F),
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
