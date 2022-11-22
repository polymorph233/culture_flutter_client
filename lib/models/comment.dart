enum Star {
  star1, star2, star3, star4, star5,
}

class Comment {
  final String? title;
  final String? content;
  final Star star;

  final List<String> appendComments = [];

  Comment({this.title, this.content, required this.star});
}