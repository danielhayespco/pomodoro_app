import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';
import '../theme/theme_provider.dart';
import '../theme/colors.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerNotifierProvider);
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final currentTheme = ref.watch(themeNotifierProvider);
    final selectedTimer = ref.watch(selectedTimerProvider);

    String getButtonText() {
      if (timerState.time == 0) {
        return 'RESTART';
      } else {
        return timerState.isRunning ? 'PAUSE' : 'START';
      }
    }

    void handleRestart() {
      if (selectedTimer == TimerType.pomodoro) {
        timerNotifier.setPomodoro();
      } else if (selectedTimer == TimerType.shortBreak) {
        timerNotifier.setShortBreak();
      } else if (selectedTimer == TimerType.longBreak) {
        timerNotifier.setLongBreak();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text('pomodoro', style: Theme.of(context).textTheme.headlineLarge),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[600]),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SettingsScreen(
                    pomodoroDuration: timerNotifier.pomodoroDuration,
                    shortBreakDuration: timerNotifier.shortBreakDuration,
                    longBreakDuration: timerNotifier.longBreakDuration,
                    onPomodoroDurationChanged: (value) {
                      timerNotifier.updatePomodoroDuration(value);
                    },
                    onShortBreakDurationChanged: (value) {
                      timerNotifier.updateShortBreakDuration(value);
                    },
                    onLongBreakDurationChanged: (value) {
                      timerNotifier.updateLongBreakDuration(value);
                    },
                    onColorChanged: (color) {
                      ref
                          .read(themeNotifierProvider.notifier)
                          .setThemeColor(color);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
              child: ToggleButtons(
                renderBorder: false,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: selectedTimer == TimerType.pomodoro
                          ? Theme.of(context).colorScheme.secondary
                          : AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text('pomodoro',
                        style: TextStyle(
                          color: selectedTimer == TimerType.pomodoro
                              ? currentTheme.scaffoldBackgroundColor
                              : Colors.grey[600],
                          fontFamily: 'KumbhSans',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: selectedTimer == TimerType.shortBreak
                          ? Theme.of(context).colorScheme.secondary
                          : AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text('short break',
                        style: TextStyle(
                          color: selectedTimer == TimerType.shortBreak
                              ? currentTheme.scaffoldBackgroundColor
                              : Colors.grey[600],
                          fontFamily: 'KumbhSans',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: selectedTimer == TimerType.longBreak
                          ? Theme.of(context).colorScheme.secondary
                          : AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text('long break',
                        style: TextStyle(
                          color: selectedTimer == TimerType.longBreak
                              ? currentTheme.scaffoldBackgroundColor
                              : Colors.grey[600],
                          fontFamily: 'KumbhSans',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
                isSelected: [
                  selectedTimer == TimerType.pomodoro,
                  selectedTimer == TimerType.shortBreak,
                  selectedTimer == TimerType.longBreak,
                ],
                onPressed: (int index) {
                  if (index == 0) {
                    timerNotifier.setPomodoro();
                  } else if (index == 1) {
                    timerNotifier.setShortBreak();
                  } else if (index == 2) {
                    timerNotifier.setLongBreak();
                  }
                  ref.read(selectedTimerProvider.notifier).state =
                      TimerType.values[index];
                },
                color: Colors.white,
                selectedColor: currentTheme.colorScheme.secondary,
                fillColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (timerState.time == 0) {
                  handleRestart(); // Restart the timer to the selected duration
                } else if (timerState.isRunning) {
                  timerNotifier.stopTimer();
                } else {
                  timerNotifier.startTimer();
                }
              },
              child: Container(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: CircularProgressIndicator(
                        value: (timerState.time /
                                (selectedTimer == TimerType.pomodoro
                                    ? timerNotifier.pomodoroDuration
                                    : selectedTimer == TimerType.shortBreak
                                        ? timerNotifier.shortBreakDuration
                                        : timerNotifier.longBreakDuration)) /
                            60,
                        strokeWidth: 10,
                        color: currentTheme.colorScheme.secondary,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(timerState.time / 60).floor().toString().padLeft(2, '0')}:${(timerState.time % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getButtonText(),
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.grey[600]),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsScreen(
                      pomodoroDuration: timerNotifier.pomodoroDuration,
                      shortBreakDuration: timerNotifier.shortBreakDuration,
                      longBreakDuration: timerNotifier.longBreakDuration,
                      onPomodoroDurationChanged: (value) {
                        timerNotifier.updatePomodoroDuration(value);
                      },
                      onShortBreakDurationChanged: (value) {
                        timerNotifier.updateShortBreakDuration(value);
                      },
                      onLongBreakDurationChanged: (value) {
                        timerNotifier.updateLongBreakDuration(value);
                      },
                      onColorChanged: (color) {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .setThemeColor(color);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
