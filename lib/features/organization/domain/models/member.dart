class Member {
  final int id;
  final String username;
  final String email;
  final String? phone;
  final String? address;
  final String? image;
  final String? sosPin;
  final String accessToken;

  // // can have list of organization IDs
  // final List<int>? organizationIds;

  Member({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    this.phone,
    this.address,
    this.image,
    this.sosPin,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      sosPin: json['sosPin'] ?? '',
      accessToken: json['tokens']["accessToken"] ?? '',
    );
  }

  // implement to json method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'sosPin': sosPin,
      'tokens': {
        'accessToken': accessToken,
      },
    };
  }
}
