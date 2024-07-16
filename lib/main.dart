import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'theme_provider.dart';

void main() {
  runApp(ProviderScope(child: PomodoroApp()));
}

class PomodoroApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Pomodoro App',
      theme: theme,
      home: HomeScreen(),
    );
  }
}
