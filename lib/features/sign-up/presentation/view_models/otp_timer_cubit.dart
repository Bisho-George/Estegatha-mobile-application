import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wakelock/wakelock.dart';

part 'otp_timer_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  Timer? _timer;

  OtpTimerCubit(super.initialState);


  void startTimer(int? time) {
    Wakelock.enable();
    if (time != null) {
      emit(OtpTimerRunInProgress(time));
    }
    else {
      emit(OtpTimerRunComplete());
    }
    _timer = Timer.periodic(const  Duration(seconds: 1), onTick );
  }

  void onTick(Timer timer) {
    if (state.timeRemaining == 0) {
      cancelTimer();
      Wakelock.disable();
      emit(OtpTimerRunComplete());
    } else {
      emit(OtpTimerRunInProgress(state.timeRemaining! - 1));
    }
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    cancelTimer();
    return super.close();
  }
}
