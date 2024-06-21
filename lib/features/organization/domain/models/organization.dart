class Organization {
  int? id;
  String? name;
  String? type;
  String? organizationCode;
  String? joinToken;
  int? organizationSize;
  // Null organizationBoundaries;
  // Post? posts;

  Organization({
    this.id,
    this.name,
    this.type,
    this.organizationCode,
    this.joinToken,
    this.organizationSize,
    // this.organizationBoundaries,
    // this.posts
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    organizationCode = json['organizationCode'];
    joinToken = json['joinToken'];
    organizationSize = json['organizationSize'];
    // organizationBoundaries = json['organizationBoundaries'];
    // posts = json['posts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['organizationCode'] = this.organizationCode;
    data['joinToken'] = this.joinToken;
    data['organizationSize'] = this.organizationSize;
    // data['organizationBoundaries'] = this.organizationBoundaries;
    // data['posts'] = this.posts;
    return data;
  }
}
