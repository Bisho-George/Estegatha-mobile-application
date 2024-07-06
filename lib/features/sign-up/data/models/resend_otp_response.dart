class ResendOtpResponse {
   final bool? success;
  final String message;

  ResendOtpResponse({required this.message, this.success});

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponse(
      message: json['message'],
      success: json['success'],
    );
  }
}