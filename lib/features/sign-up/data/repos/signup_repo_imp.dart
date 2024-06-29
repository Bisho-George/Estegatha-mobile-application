import 'package:dartz/dartz.dart';
import 'package:estegatha/features/sign-up/data/data_source/signup_data_source.dart';
import 'package:estegatha/features/sign-up/data/models/signup_request_body.dart';
import 'package:estegatha/features/sign-up/data/models/signup_response.dart';
import 'package:estegatha/features/sign-up/domain/repos/signup_repo.dart';

class SignupRepoImp extends SignupRepo {
  final SignupDataSource signupDataSource;

  SignupRepoImp({required this.signupDataSource});

  @override
  Future<Either<Failure, SignupResponse>> signup(SignupRequestBody signupRequestBody) async {
    var result = await signupDataSource.signup();
    
    // TODO: implement signup
    throw UnimplementedError();
  }

}