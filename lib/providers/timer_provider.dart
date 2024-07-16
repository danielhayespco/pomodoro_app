import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimerType { pomodoro, shortBreak, longBreak }

class TimerState {
  final int time;
  final bool isRunning;

  TimerState({required this.time, required this.isRunning});
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState(time: 25 * 60, isRunning: false));
  Timer? _timer;
  int pomodoroDuration = 25;
  int shortBreakDuration = 5;
  int longBreakDuration = 15;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.time > 0) {
        state = TimerState(time: state.time - 1, isRunning: true);
      } else {
        _timer?.cancel();
        state = TimerState(time: state.time, isRunning: false);
      }
    });
    state = TimerState(time: state.time, isRunning: true);
  }

  void stopTimer() {
    _timer?.cancel();
    state = TimerState(time: state.time, isRunning: false);
  }

  void setPomodoro() {
    state = TimerState(time: pomodoroDuration * 60, isRunning: false);
    stopTimer();
  }

  void setShortBreak() {
    state = TimerState(time: shortBreakDuration * 60, isRunning: false);
    stopTimer();
  }

  void setLongBreak() {
    state = TimerState(time: longBreakDuration * 60, isRunning: false);
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

final timerNotifierProvider =
    StateNotifierProvider<TimerNotifier, TimerState>((ref) {
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
