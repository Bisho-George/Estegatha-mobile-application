import 'package:estegatha/utils/services/api_service.dart';

import '../models/verify_otp_request.dart';
import '../models/verify_otp_response.dart';

abstract class VerifyOtpDataSource {
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest);
}

class VerifyOtpDataSourceImp extends VerifyOtpDataSource {
  final ApiService apiService;

  VerifyOtpDataSourceImp(this.apiService);

  @override
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest) async{
    var result = await apiService.post(endpoint: 'api/v1/auth/verify', data: {
      'email': verifyOtpRequest.email,
      'otp': verifyOtpRequest.otp,
    });
    return VerifyOtpResponse(
      success: result?.data['status'],
      message: result.data['message'] ?? result.data,
    );
  }
}
