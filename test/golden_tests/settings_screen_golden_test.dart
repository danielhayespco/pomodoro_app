import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';
import 'package:pomodoro_app/theme/theme_provider.dart';

void main() {
  group('SettingsScreen Golden Tests', () {
    testGoldens('SettingsScreen - Light mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeNotifierProvider.overrideWithValue(
              ThemeNotifier()..setThemeColor(const Color(0xFF70F3F8)),
            ),
          ],
          child: MaterialApp(
            home: SettingsScreen(
              pomodoroDuration: 25,
              shortBreakDuration: 5,
              longBreakDuration: 15,
              onColorChanged: (color) {},
              onFontChanged: (font) {},
            ),
          ),
        ),
      );

      await screenMatchesGolden(tester, 'settings_screen_light');
    });

    testGoldens('SettingsScreen - Dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeNotifierProvider.overrideWithValue(
              ThemeNotifier()..setThemeColor(const Color(0xFF161932)),
            ),
          ],
          child: MaterialApp(
            home: SettingsScreen(
              pomodoroDuration: 25,
              shortBreakDuration: 5,
              longBreakDuration: 15,
              onColorChanged: (color) {},
              onFontChanged: (font) {},
            ),
          ),
        ),
      );

      await screenMatchesGolden(tester, 'settings_screen_dark');
    });
  });
}
