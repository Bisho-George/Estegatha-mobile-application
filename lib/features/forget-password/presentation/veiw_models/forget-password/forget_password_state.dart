part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String errMessage;

  ForgetPasswordFailure({required this.errMessage});
}

class ChangePasswordLoading extends ForgetPasswordState {}

class ChangePasswordSuccess extends ForgetPasswordState {}

class ChangePasswordFailure extends ForgetPasswordState {
  final String errMessage;

  ChangePasswordFailure({required this.errMessage});
}
