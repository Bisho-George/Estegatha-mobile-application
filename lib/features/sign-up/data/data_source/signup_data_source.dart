import 'package:estegatha/features/sign-up/data/models/signup_request_body.dart';
import 'package:estegatha/features/sign-up/data/models/signup_response.dart';
import 'package:estegatha/utils/services/api_service.dart';

abstract class SignupDataSource {
  Future<SignupResponse> signup(SignupRequestBody signupRequestBody);
}

class SignupDataSourceImp extends SignupDataSource {
  final ApiService apiService;

  SignupDataSourceImp(this.apiService);

  @override
  Future<SignupResponse> signup(SignupRequestBody signupRequestBody) async {
    var result = await apiService.post(endpoint: 'api/v1/auth/register', data: {
      'username': signupRequestBody.username,
      'email': signupRequestBody.email,
      'password': signupRequestBody.password,
      'phone': signupRequestBody.phone,
      'address': signupRequestBody.address,
      'lat': signupRequestBody.lat,
      'lng': signupRequestBody.lng,
    }
    , isSignup: false);
    return SignupResponse(status: result.statusCode);
  }
}
