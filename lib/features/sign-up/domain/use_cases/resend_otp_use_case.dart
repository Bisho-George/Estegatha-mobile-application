import 'package:dartz/dartz.dart';
import 'package:estegatha/utils/helpers/use_case.dart';

import '../../data/failure/failure.dart';
import '../../data/models/resend_otp_request.dart';
import '../../data/models/resend_otp_response.dart';
import '../../data/repos/resend_otp_repo_imp.dart';

class ResendOtpUseCase extends UseCase<ResendOtpResponse, ResendOtpRequest> {
  final ResendOtpRepoImp _resendOtpRepo;

  ResendOtpUseCase(this._resendOtpRepo);



  @override
  Future<Either<Failure, ResendOtpResponse>> call(
      ResendOtpRequest resendOtpRequest) async {
    return await _resendOtpRepo.resendOtp(resendOtpRequest);
  }
}