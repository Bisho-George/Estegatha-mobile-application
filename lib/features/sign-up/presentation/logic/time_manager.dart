import 'dart:async';
import 'package:wakelock/wakelock.dart';

class TimerManager {
  late int _timeRemaining;
  Timer? _timer;

  void startTimer(int time, Function(int) onTick, Function onTimerComplete) {
    _timeRemaining = time;
    Wakelock.enable();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        onTick(_timeRemaining);
        _timeRemaining--;
      } else {
        _timer?.cancel();
        Wakelock.disable();
        onTimerComplete();
      }
    });
  }

  void resetTimer(int time, Function(int) onTick, Function onTimerComplete) {
    startTimer(time, onTick, onTimerComplete);
  }

  void cancelTimer() {
    _timer?.cancel();
    Wakelock.disable();
  }
}
