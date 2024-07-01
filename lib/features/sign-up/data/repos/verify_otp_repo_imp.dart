import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:estegatha/features/sign-up/data/data_source/verify_otp_data_source.dart';
import 'package:estegatha/features/sign-up/data/failure/failure.dart';
import 'package:estegatha/features/sign-up/data/models/verify_otp_request.dart';
import 'package:estegatha/features/sign-up/data/models/verify_otp_response.dart';
import 'package:estegatha/features/sign-up/domain/repos/verify_otp_repo.dart';

class VerifyOtpRepoImp extends VerifyOtpRepo {
  final VerifyOtpDataSource verifyOtpDataSource;

  VerifyOtpRepoImp({required this.verifyOtpDataSource});

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      VerifyOtpRequest verifyOtpRequest) async {
    try {
      var result = await verifyOtpDataSource.verifyOtp(verifyOtpRequest);
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
