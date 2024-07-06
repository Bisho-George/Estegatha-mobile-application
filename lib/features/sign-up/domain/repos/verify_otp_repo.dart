import 'package:dartz/dartz.dart';

import '../../data/failure/failure.dart';
import '../../data/models/verify_otp_request.dart';
import '../../data/models/verify_otp_response.dart';

abstract class VerifyOtpRepo {
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest verifyOtpRequest);
}