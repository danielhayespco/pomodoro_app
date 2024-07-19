import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimerType { pomodoro, shortBreak, longBreak }

class TimerState {
  final int time;
  final bool isRunning;

  TimerState({required this.time, required this.isRunning});
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier(this._read)
      : super(TimerState(time: 25 * 60, isRunning: false));
  final Reader _read;
  Timer? _timer;
  int pomodoroDuration = 25;
  int shortBreakDuration = 5;
  int longBreakDuration = 15;

  TimerType get selectedTimer => _read(selectedTimerProvider);

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
    if (selectedTimer == TimerType.pomodoro) {
      setPomodoro();
    }
  }

  void updateShortBreakDuration(int duration) {
    shortBreakDuration = duration;
    if (selectedTimer == TimerType.shortBreak) {
      setShortBreak();
    }
  }

  void updateLongBreakDuration(int duration) {
    longBreakDuration = duration;
    if (selectedTimer == TimerType.longBreak) {
      setLongBreak();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerNotifierProvider =
    StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(ref.read);
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
