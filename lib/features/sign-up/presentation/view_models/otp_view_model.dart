import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_view_model.dart';

class OtpViewModel {
  final SignUpViewModel signUpViewModel;

  OtpViewModel(this.signUpViewModel);

  String getOtp() {
    String otp = '';
    for (var field in signUpViewModel.otpControllers) {
      otp += field.text;
    }
    return otp;
  }
}
