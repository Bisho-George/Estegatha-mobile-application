class Post {
  int? id;
  String? title;
  String? content;
  String? author;
  String? publishedAt;
  int? organizationId;

  Post(
      {this.id,
      this.title,
      this.content,
      this.author,
      this.publishedAt,
      this.organizationId});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    author = json['author'];
    publishedAt = json['publishedAt'];
    organizationId = json['organizationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['author'] = this.author;
    data['publishedAt'] = this.publishedAt;
    data['organizationId'] = this.organizationId;
    return data;
  }
}
