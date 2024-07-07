import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/resend_otp_repo.dart';
import '../data_source/resend_otp_data_source.dart';
import '../../../../utils/helpers/failure.dart';
import '../models/resend_otp_request.dart';
import '../models/resend_otp_response.dart';

class ResendOtpRepoImp extends ResendOtpRepo {
  final ResendOtpDataSource resendOtpDataSource;

  ResendOtpRepoImp({required this.resendOtpDataSource});

  @override
  Future<Either<Failure, ResendOtpResponse>> resendOtp(
      ResendOtpRequest resendOtpRequest) async {
    try {
      final response = await resendOtpDataSource.resendOtp(resendOtpRequest);
      return Right(response);
    }  catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}