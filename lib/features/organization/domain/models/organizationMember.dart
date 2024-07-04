class OrganizationMember {
  int? userId;
  String? username;
  String? role;
  String? status;

  OrganizationMember({this.userId, this.username, this.role, this.status});

  OrganizationMember.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['role'] = role;
    data['status'] = status;
    return data;
  }
}
