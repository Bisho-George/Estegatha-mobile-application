class Post {
  final int id;
  final String title;
  final String content;
  final int organizationId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.organizationId,
  }) : assert(id >= 0, 'Post id cannot be less than 0');

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      organizationId: json['organizationId'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, content: $content, organizationId: $organizationId}';
  }
}
