import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
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

    final bool isMobile = MediaQuery.of(context).size.width < 600;

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
              padding: EdgeInsets.only(top: isMobile ? 24.0 : 75.0),
              child: Column(
                children: [
                  Text(
                    'pomodoro',
                    style: TextStyle(
                      fontFamily: 'KumbhSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFFD7E0FF),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: isMobile ? 327 : null,
                    height: isMobile ? 63 : null,
                    constraints: isMobile
                        ? null
                        : BoxConstraints(minWidth: AppButtonStyles.rowMinWidth),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: isMobile ? 0 : 10.0),
                    child: ToggleButtons(
                      renderBorder: false,
                      children: [
                        Container(
                          width: isMobile ? 106 : AppButtonStyles.buttonWidth,
                          height: isMobile ? 48 : AppButtonStyles.buttonHeight,
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
                                    : Color(0xFFD7E0FF).withOpacity(.45),
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 11 : 14,
                              )),
                        ),
                        Container(
                          width: isMobile ? 106 : AppButtonStyles.buttonWidth,
                          height: isMobile ? 48 : AppButtonStyles.buttonHeight,
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
                                    : Color(0xFFD7E0FF).withOpacity(.45),
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 11 : 14,
                              )),
                        ),
                        Container(
                          width: isMobile ? 106 : AppButtonStyles.buttonWidth,
                          height: isMobile ? 48 : AppButtonStyles.buttonHeight,
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
                                    : Color(0xFFD7E0FF).withOpacity(.45),
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 11 : 14,
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
                width: isMobile ? 300 : 410,
                height: isMobile ? 300 : 410,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: isMobile ? 300 : 410,
                      height: isMobile ? 300 : 410,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0E112A),
                            Color(0xFF2E325A),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2E325A).withOpacity(
                                0.8), // Increased opacity for more presence
                            offset: Offset(-25,
                                -25), // Increased offset for more dramatic effect
                            blurRadius: 30, // Increased blur radius
                          ),
                          BoxShadow(
                            color: Color(0xFF0E112A).withOpacity(
                                0.7), // Increased opacity for more presence
                            offset: Offset(10,
                                10), // Increased offset for more dramatic effect
                            blurRadius: 30, // Increased blur radius
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: isMobile ? 268 : 366,
                      height: isMobile ? 268 : 366,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF0E112A).withOpacity(
                                0.7), // Increased opacity for more presence
                            offset: Offset(-8,
                                -8), // Increased offset for more dramatic effect
                            blurRadius: 25, // Increased blur radius
                          ),
                          BoxShadow(
                            color: Color(0xFF2E325A).withOpacity(
                                0.7), // Increased opacity for more presence
                            offset: Offset(8,
                                8), // Increased offset for more dramatic effect
                            blurRadius: 30, // Increased blur radius
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? 248 : 339,
                      height: isMobile ? 248 : 339,
                      child: CircularProgressIndicator(
                        value: (timerState.time /
                                (selectedTimer == TimerType.pomodoro
                                    ? timerNotifier.pomodoroDuration
                                    : selectedTimer == TimerType.shortBreak
                                        ? timerNotifier.shortBreakDuration
                                        : timerNotifier.longBreakDuration)) /
                            60,
                        strokeWidth: isMobile ? 8 : 10,
                        color: currentTheme.colorScheme.secondary,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(timerState.time / 60).floor().toString().padLeft(2, '0')}:${(timerState.time % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                              fontSize: isMobile ? 80 : 100,
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
                              fontSize: isMobile ? 15 : 16,
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
              padding: EdgeInsets.only(bottom: isMobile ? 40 : 80.0),
              child: IconButton(
                icon: Icon(Icons.settings,
                    color: Color(0xFFD7E0FF).withOpacity(.45), size: 34),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SettingsScreen(
                        pomodoroDuration: timerNotifier.pomodoroDuration,
                        shortBreakDuration: timerNotifier.shortBreakDuration,
                        longBreakDuration: timerNotifier.longBreakDuration,
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
