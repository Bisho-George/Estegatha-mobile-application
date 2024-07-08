class OrganizationMember {
  int? userId;
  String? username;
  String? role;
  String? status;
  String? lat;
  String? lang;

  OrganizationMember({this.userId, this.username, this.role, this.status, this.lat, this.lang});

  OrganizationMember.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    role = json['role'];
    status = json['status'];
    lat = json['lat'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['role'] = role;
    data['status'] = status;
    data['lat'] = lat;
    data['lang'] = lang;
    return data;
  }
}
