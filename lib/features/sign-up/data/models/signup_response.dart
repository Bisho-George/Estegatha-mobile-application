class SignupResponse {
  final int status;

  SignupResponse({
    required this.status,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      status: json['status'],
    );
  }
}
