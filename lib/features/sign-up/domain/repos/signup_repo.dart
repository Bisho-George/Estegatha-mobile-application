import 'package:dartz/dartz.dart';
import 'package:estegatha/features/sign-up/data/failure/failure.dart';
import 'package:estegatha/features/sign-up/data/models/signup_request_body.dart';
import 'package:estegatha/features/sign-up/data/models/signup_response.dart';

abstract class SignupRepo {
  Future<Either<Failure, SignupResponse>> signup(SignupRequestBody signupRequestBody);
}