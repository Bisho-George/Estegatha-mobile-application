import 'package:dartz/dartz.dart';
import 'package:estegatha/features/sign-up/data/models/verify_otp_request.dart';
import 'package:estegatha/features/sign-up/data/models/verify_otp_response.dart';
import 'package:estegatha/features/sign-up/domain/repos/verify_otp_repo.dart';

import '../../../../utils/helpers/failure.dart';

class VerifyOtpUseCase {
  final VerifyOtpRepo _repository;

  VerifyOtpUseCase(this._repository);

  Future<Either<Failure, VerifyOtpResponse>> call(VerifyOtpRequest otp) async {
    return await _repository.verifyOtp(otp);
  }
}