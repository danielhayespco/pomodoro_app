import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/main.dart'; // Ensure this is the correct path
import 'package:pomodoro_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen initial state test', (WidgetTester tester) async {
    // Build the HomeScreen widget.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Verify initial timer state
    expect(find.text('25:00'), findsOneWidget);
    expect(find.text('START'), findsOneWidget);

    // Verify initial pomodoro mode
    expect(find.text('pomodoro'), findsOneWidget);
  });

  testWidgets('HomeScreen start timer test', (WidgetTester tester) async {
    // Build the HomeScreen widget.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Start the timer
    await tester.tap(find.text('START'));
    await tester.pump();

    // Verify the timer starts
    expect(find.text('PAUSE'), findsOneWidget);
  });
}
