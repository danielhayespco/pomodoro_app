import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';
import '../theme/theme_provider.dart';
import '../theme/colors.dart';
import '../theme/button_styles.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerNotifierProvider);
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final currentTheme = ref.watch(themeNotifierProvider);
    final selectedTimer = ref.watch(selectedTimerProvider);
    final fontFamily =
        ref.watch(themeNotifierProvider.notifier).currentFontFamily;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  Text(
                    'pomodoro',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontFamily: fontFamily,
                        ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: AppButtonStyles.rowHeight,
                    constraints:
                        BoxConstraints(minWidth: AppButtonStyles.rowMinWidth),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                    child: ToggleButtons(
                      renderBorder: false,
                      children: [
                        Container(
                          width: AppButtonStyles.buttonWidth,
                          height: AppButtonStyles.buttonHeight,
                          decoration: BoxDecoration(
                            color: selectedTimer == TimerType.pomodoro
                                ? Theme.of(context).colorScheme.secondary
                                : AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Text('pomodoro',
                              style: TextStyle(
                                color: selectedTimer == TimerType.pomodoro
                                    ? currentTheme.scaffoldBackgroundColor
                                    : Colors.grey[600],
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          width: AppButtonStyles.buttonWidth,
                          height: AppButtonStyles.buttonHeight,
                          decoration: BoxDecoration(
                            color: selectedTimer == TimerType.shortBreak
                                ? Theme.of(context).colorScheme.secondary
                                : AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Text('short break',
                              style: TextStyle(
                                color: selectedTimer == TimerType.shortBreak
                                    ? currentTheme.scaffoldBackgroundColor
                                    : Colors.grey[600],
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          width: AppButtonStyles.buttonWidth,
                          height: AppButtonStyles.buttonHeight,
                          decoration: BoxDecoration(
                            color: selectedTimer == TimerType.longBreak
                                ? Theme.of(context).colorScheme.secondary
                                : AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Text('long break',
                              style: TextStyle(
                                color: selectedTimer == TimerType.longBreak
                                    ? currentTheme.scaffoldBackgroundColor
                                    : Colors.grey[600],
                                fontFamily: fontFamily,
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (timerState.time == 0) {
                  handleRestart();
                } else if (timerState.isRunning) {
                  timerNotifier.stopTimer();
                } else {
                  timerNotifier.startTimer();
                }
              },
              child: Container(
                width: 410,
                height: 410,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 339,
                      height: 339,
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
                              fontSize: 100,
                              fontFamily: fontFamily,
                              color: Color(0xFFD7E0FF),
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: -5),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getButtonText(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily,
                              color: Color(0xFFD7E0FF),
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: 15,
                              textBaseline: TextBaseline.alphabetic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.grey[600], size: 28),
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
                        onFontChanged: (fontFamily) {
                          ref
                              .read(themeNotifierProvider.notifier)
                              .setFontFamily(fontFamily);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
