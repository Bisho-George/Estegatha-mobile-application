class SignupRequestBody {
  final String email;
  final String password;
  final String username;
  final String phone;
  final String address;
  final List<String>? roles;
  final String lat;
  final String lng;

  SignupRequestBody({
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
    required this.address,
    this.roles,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'phone': phone,
      'address': address,
      'roles': roles,
      'lat': lat,
      'lng': lng,
    };
  }
  
}
