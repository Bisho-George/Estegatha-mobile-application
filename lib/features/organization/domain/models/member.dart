class Member {
  final int id;
  final String name;
  final String email;
  final String password;
  // can have list of organization IDs
  final List<int>? organizationIds;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    List<int>? organizationIds,
  }) : organizationIds = organizationIds ?? [];

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['memberId'], // If id is null, assign 0
      name: json['name'] ?? '', // If name is null, assign an empty string
      email: json['email'] ?? '', // If email is null, assign an empty string
      password:
          json['password'] ?? '', // If password is null, assign an empty string
      organizationIds: json['organizationIds'] != null
          ? List<int>.from(json['organizationIds'])
          : null,
    );
  }
}
