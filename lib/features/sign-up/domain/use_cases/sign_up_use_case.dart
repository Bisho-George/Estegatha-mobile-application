import 'package:dartz/dartz.dart';
import 'package:estegatha/utils/helpers/failure.dart';
import 'package:estegatha/features/sign-up/data/models/signup_request_body.dart';
import 'package:estegatha/features/sign-up/data/models/signup_response.dart';
import 'package:estegatha/features/sign-up/domain/repos/signup_repo.dart';
import 'package:estegatha/utils/helpers/use_case.dart';

class SignupUseCase extends UseCase<SignupResponse, SignupRequestBody>{
  final SignupRepo _signupRepo;

  SignupUseCase(this._signupRepo);

  // @override
  // Future<Either<Failure, SignupResponse>> call([SignupRequestBody? param]) {
  //   // TODO: implement call
  //   throw UnimplementedError();
  // }
  
  @override
  Future<Either<Failure, SignupResponse>> call([SignupRequestBody? param]) async {
    return await _signupRepo.signup(param!);
  }



}