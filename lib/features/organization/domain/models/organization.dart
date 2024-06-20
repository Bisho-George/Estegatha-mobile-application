class Organization {
  final int id;
  final String name;
  final String code;
  // can have list of member IDs
  final List<int>? memberIds;

  Organization({
    required this.id,
    required this.name,
    required this.code,
    this.memberIds,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      code: json['organizationCode'],
    );
  }
}
