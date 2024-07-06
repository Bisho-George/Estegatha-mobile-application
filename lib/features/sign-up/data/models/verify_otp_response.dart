class VerifyOtpResponse {
  final bool? success;
  final String message;

  VerifyOtpResponse({required this.message, this.success});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'],
      success: json['success'],
    );
  }
}