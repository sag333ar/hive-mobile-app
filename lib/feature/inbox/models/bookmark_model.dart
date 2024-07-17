import 'dart:convert';

class BookmarkModel {
  final String body;
  final String title;
  final String author;
  final String permlink;
  final String? id;

  BookmarkModel({
    required this.body,
    required this.title,
    required this.author,
    required this.permlink,
    this.id,
  });

  BookmarkModel copyWith({
    String? body,
    String? title,
    String? author,
    String? permlink,
    String? id,
  }) =>
      BookmarkModel(
        body: body ?? this.body,
        title: title ?? this.title,
        author: author ?? this.author,
        permlink: permlink ?? this.permlink,
        id: id ?? this.id,
      );

  factory BookmarkModel.fromRawJson(String str) =>
      BookmarkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        body: json["body"],
        title: json["title"],
        author: json["author"],
        permlink: json["permlink"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
        "author": author,
        "permlink": permlink,
      };
}
