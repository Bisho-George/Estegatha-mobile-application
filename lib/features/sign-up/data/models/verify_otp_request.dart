import 'package:estegatha/features/sign-up/domain/entities/otp_entity.dart';

class VerifyOtpRequest extends OtpEntity{
  final String otp;
  final String email;

  VerifyOtpRequest({
    required this.otp,
    required this.email,
  }): super(otp: otp);

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'email': email,
    };
  }
}