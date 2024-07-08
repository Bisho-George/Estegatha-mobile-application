import '../../../../utils/services/api_service.dart';
import '../models/resend_otp_request.dart';
import '../models/resend_otp_response.dart';

abstract class ResendOtpDataSource {
  Future<ResendOtpResponse> resendOtp(ResendOtpRequest resendOtpRequest);
}

class ResendOtpDataSourceImp extends ResendOtpDataSource {
  final ApiService apiService;

  ResendOtpDataSourceImp(this.apiService);

  @override
  Future<ResendOtpResponse> resendOtp(ResendOtpRequest resendOtpRequest) async {
    var result = await apiService.post(
      endpoint: 'api/v1/auth/resend-otp',
      queryParams: {
        'email': resendOtpRequest.email,
      },
      isSignup: false,
    );
    return ResendOtpResponse(
        message: result.data['message'] ?? result.data,
        success: result.data['status'] ?? true);
  }
}
