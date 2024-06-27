part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpPersonalInfoState extends SignUpState {
  final PersonalInfoModel personalInfo;

  SignUpPersonalInfoState(this.personalInfo);
}

class SignUpEmailState extends SignUpState {
  final String email;

  SignUpEmailState(this.email);
}

class SignUpPasswordState extends SignUpState {
  final String password;

  SignUpPasswordState(this.password);
}

class SignUpOTPState extends SignUpState {
  final String otp;

  SignUpOTPState(this.otp);
}

class SignUpAddressState extends SignUpState {
  final String address;

  SignUpAddressState(this.address);
}

class SignUpSubmitState extends SignUpState {
  final UserModel userModel;

  SignUpSubmitState(this.userModel);
}
