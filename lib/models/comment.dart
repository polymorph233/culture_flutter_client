enum Star {
  star1, star2, star3, star4, star5,
}

class Comment {
  final String? title;
  final String? content;
  final Star star;

  final String author;

  final List<String> appendComments = [];

  Comment({required this.author, required this.star, this.title, this.content});
}