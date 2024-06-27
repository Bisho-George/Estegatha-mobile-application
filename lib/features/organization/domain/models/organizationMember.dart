class OrganizationMember {
  int? userId;
  String? username;
  String? role;

  OrganizationMember({this.userId, this.username, this.role});

  OrganizationMember.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['role'] = role;
    return data;
  }
}
