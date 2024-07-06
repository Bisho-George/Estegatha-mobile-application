class ResendOtpRequest {
  final String email;

  ResendOtpRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

}