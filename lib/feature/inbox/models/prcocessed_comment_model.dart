import 'dart:convert';

class ProcessedCommentModel {
  final String author;
  final String permlink;
  final String? id;

  ProcessedCommentModel({
    required this.author,
    required this.permlink,
    this.id,
  });

  ProcessedCommentModel copyWith({
    String? author,
    String? permlink,
    String? id,
  }) =>
      ProcessedCommentModel(
        author: author ?? this.author,
        permlink: permlink ?? this.permlink,
        id: id ?? this.id,
      );

  factory ProcessedCommentModel.fromRawJson(String str) =>
      ProcessedCommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProcessedCommentModel.fromJson(Map<String, dynamic> json) =>
      ProcessedCommentModel(
        author: json["author"],
        permlink: json["permlink"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "permlink": permlink,
      };
}
