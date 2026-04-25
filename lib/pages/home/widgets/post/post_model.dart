enum PostType {
  post,
  article,
}

class Post {
  final PostType type;
  final String content;
  final List<String>? images;
  final String? title;

  Post({
    required this.type,
    required this.content,
    this.images,
    this.title,
  });
}
