import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';

class QuoteModel extends Quote {
  @override
  String id;
  @override
  String author;
  @override
  String content;

  QuoteModel({
    required this.id,
    required this.author,
    required this.content,
  }) : super(
          author: author,
          id: id,
          content: content,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json["_id"],
        author: json["author"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author,
        "content": content,
      };
}
