part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

// ===========> first step = Create reset token
class CreateResetTokenLoading extends ForgetPasswordState {}

class CreateResetTokenSuccess extends ForgetPasswordState {}

class CreateResetTokenFailure extends ForgetPasswordState {
  final String errMessage;

  CreateResetTokenFailure({required this.errMessage});
}

// ===========> second step = Send reset token
class SendResetTokenLoading extends ForgetPasswordState {}

class SendResetTokenSuccess extends ForgetPasswordState {}

class SendResetTokenFailure extends ForgetPasswordState {
  final String errMessage;

  SendResetTokenFailure({required this.errMessage});
}

// ===========> third step = Reset password
class ResetPasswordLoading extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class ResetPasswordFailure extends ForgetPasswordState {
  final String errMessage;

  ResetPasswordFailure({required this.errMessage});
}

// ===========> resend reset token
class ResendResetTokenLoading extends ForgetPasswordState {}

class ResendResetTokenSuccess extends ForgetPasswordState {}

class ResendResetTokenFailure extends ForgetPasswordState {
  final String errMessage;

  ResendResetTokenFailure({required this.errMessage});
}
