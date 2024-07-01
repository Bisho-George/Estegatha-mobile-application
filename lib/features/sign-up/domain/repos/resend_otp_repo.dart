import 'package:dartz/dartz.dart';
import 'package:estegatha/features/sign-up/data/models/resend_otp_request.dart';
import 'package:estegatha/features/sign-up/data/models/resend_otp_response.dart';

import '../../data/failure/failure.dart';

abstract class ResendOtpRepo {
  Future<Either<Failure, ResendOtpResponse>> resendOtp(ResendOtpRequest resendOtpRequest);
}
