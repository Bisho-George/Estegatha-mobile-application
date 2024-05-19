part of 'otp_timer_cubit.dart';

@immutable
sealed class OtpTimerState {
   final int? timeRemaining;
  const OtpTimerState(this.timeRemaining);
}

class OtpTimerInitial extends OtpTimerState {
  OtpTimerInitial(int timeRemaining) : super(timeRemaining);

  List<Object?>  get props => [timeRemaining];
}

class OtpTimerRunInProgress extends OtpTimerState {
  OtpTimerRunInProgress(int timeRemaining) : super(timeRemaining);
}

class OtpTimerRunComplete extends OtpTimerState {
  OtpTimerRunComplete() : super(0);
}

