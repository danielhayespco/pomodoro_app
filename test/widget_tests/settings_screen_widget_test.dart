import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/theme/theme_provider.dart';
import 'package:pomodoro_app/providers/timer_provider.dart';
import 'package:pomodoro_app/widgets/dropdown_time_adjuster.dart';
import 'package:pomodoro_app/widgets/color_button.dart';
import 'package:pomodoro_app/widgets/font_button.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themeNotifierProvider.overrideWithValue(ThemeNotifier()),
          timerNotifierProvider.overrideWithValue(TimerNotifier(mockReader)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SettingsScreen(
              pomodoroDuration: 25,
              shortBreakDuration: 5,
              longBreakDuration: 15,
              onColorChanged: (color) {},
              onFontChanged: (font) {},
            ),
          ),
        ),
      ),
    );

    // Verify initial durations
    expect(find.text('pomodoro'), findsOneWidget);
    expect(find.text('short break'), findsOneWidget);
    expect(find.text('long break'), findsOneWidget);

    // Verify the presence of dropdowns for time adjustment
    expect(find.byType(DropdownTimeAdjuster), findsNWidgets(3));
  });

  testWidgets('SettingsScreen change color', (WidgetTester tester) async {
    final themeNotifier = ThemeNotifier();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themeNotifierProvider.overrideWithValue(themeNotifier),
          timerNotifierProvider.overrideWithValue(TimerNotifier(mockReader)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SettingsScreen(
              pomodoroDuration: 25,
              shortBreakDuration: 5,
              longBreakDuration: 15,
              onColorChanged: (color) {
                themeNotifier.setThemeColor(color);
              },
              onFontChanged: (font) {},
            ),
          ),
        ),
      ),
    );

    // Change the color
    await tester.tap(find.byType(ColorButton).first);
    await tester.pump();

    // Verify the theme color change
    expect(themeNotifier.currentColor, Color(0xFFF87070));
  });

  testWidgets('SettingsScreen change font', (WidgetTester tester) async {
    final themeNotifier = ThemeNotifier();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themeNotifierProvider.overrideWithValue(themeNotifier),
          timerNotifierProvider.overrideWithValue(TimerNotifier(mockReader)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SettingsScreen(
              pomodoroDuration: 25,
              shortBreakDuration: 5,
              longBreakDuration: 15,
              onColorChanged: (color) {},
              onFontChanged: (font) {
                themeNotifier.setFontFamily(font);
              },
            ),
          ),
        ),
      ),
    );

    // Change the font
    await tester.tap(find.byType(FontButton).first);
    await tester.pump();

    // Verify the font family change
    expect(themeNotifier.currentFontFamily, 'KumbhSans');
  });
}

T mockReader<T>(ProviderBase<T> provider) {
  return null as T;
}
