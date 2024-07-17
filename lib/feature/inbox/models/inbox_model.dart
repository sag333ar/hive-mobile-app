import 'dart:convert';
import 'dart:developer';

import 'package:hive_mobile_app/feature/inbox/models/bookmark_model.dart';
import 'package:hive_mobile_app/feature/inbox/models/prcocessed_comment_model.dart';

class InboxModel {
  final List<String> ignoredAuthors;
  final List<BookmarkModel> bookmarks;
  final List<ProcessedCommentModel> processedComments;

  InboxModel({
    required this.ignoredAuthors,
    required this.bookmarks,
    required this.processedComments,
  });

  InboxModel copyWith({
    List<String>? ignoredAuthors,
    List<BookmarkModel>? bookmarks,
    List<ProcessedCommentModel>? processedComments,
  }) =>
      InboxModel(
        ignoredAuthors: ignoredAuthors ?? this.ignoredAuthors,
        bookmarks: bookmarks ?? this.bookmarks,
        processedComments: processedComments ?? this.processedComments,
      );

  factory InboxModel.fromRawJson(String str) =>
      InboxModel.fromJson(json.decode(str));

  String toRawJson() {
    log(json.encode(toJson()));
    return json.encode(toJson());
  }

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        ignoredAuthors: List<String>.from(json["ignoredAuthors"].map((x) => x)),
        bookmarks: List<BookmarkModel>.from(
            json["bookmarks"].map((x) => BookmarkModel.fromJson(x))),
        processedComments: List<ProcessedCommentModel>.from(
            json["processedComments"]
                .map((x) => ProcessedCommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ignoredAuthors": List<dynamic>.from(ignoredAuthors.map((x) => x)),
        "bookmarks": List<dynamic>.from(bookmarks.map((x) => x.toJson())),
        "processedComments":
            List<dynamic>.from(processedComments.map((x) => x.toJson())),
      };
}
