import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimerType { pomodoro, shortBreak, longBreak }

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(25 * 60);
  Timer? _timer;
  bool isRunning = false;
  int pomodoroDuration = 25;
  int shortBreakDuration = 5;
  int longBreakDuration = 15;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer?.cancel();
      }
    });
    isRunning = true;
  }

  void stopTimer() {
    _timer?.cancel();
    isRunning = false;
  }

  void setPomodoro() {
    state = pomodoroDuration * 60;
    stopTimer();
  }

  void setShortBreak() {
    state = shortBreakDuration * 60;
    stopTimer();
  }

  void setLongBreak() {
    state = longBreakDuration * 60;
    stopTimer();
  }

  void updatePomodoroDuration(int duration) {
    pomodoroDuration = duration;
  }

  void updateShortBreakDuration(int duration) {
    shortBreakDuration = duration;
  }

  void updateLongBreakDuration(int duration) {
    longBreakDuration = duration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class SelectedTimerNotifier extends StateNotifier<TimerType> {
  SelectedTimerNotifier() : super(TimerType.pomodoro);

  void setTimer(TimerType timerType) {
    state = timerType;
  }
}

final selectedTimerProvider =
    StateNotifierProvider<SelectedTimerNotifier, TimerType>((ref) {
  return SelectedTimerNotifier();
});
