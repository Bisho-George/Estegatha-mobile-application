part of 'resend_otp_cubit.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}

final class ResendOtpLoadingState extends ResendOtpState {}

final class ResendOtpSuccessState extends ResendOtpState {
  final String message;

  ResendOtpSuccessState(this.message);
}

final class ResendOtpFailureState extends ResendOtpState {
  final String message;

  ResendOtpFailureState(this.message);
}
