class ReviewModel {
  final String author;
  final String content;

  ReviewModel({required this.author, required this.content});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      author: json['author'] as String,
      content: json['content'] as String,
    );
  }
}
