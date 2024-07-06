part of 'verify_email_cubit.dart';

@immutable
sealed class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

final class OtpUpdatedState extends VerifyEmailState {
  final String otp;

  OtpUpdatedState(this.otp);
}

final class VerifyEmailLoadingState extends VerifyEmailState {}

final class VerifyEmailSuccessState extends VerifyEmailState {
  final String message;

  VerifyEmailSuccessState(this.message);
}

final class VerifyEmailFailureState extends VerifyEmailState {
  final String message;

  VerifyEmailFailureState(this.message);
}
