import 'dart:convert';

import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class CommentModel {
  static List<PostFeedModel> fromRawJson(String str) =>
      CommentModel.parseComments(json.decode(str)['data']);

  static List<PostFeedModel> parseComments(Map<String, dynamic>? json) {
    try {
      List<PostFeedModel> items = [];
      if (json != null) {
        int count = 0;
        json.forEach((key, value) {
          if (count != 0) {
            items.add(PostFeedModel.fromJson(value));
          }
          count++;
        });
      }
      return items;
    } catch (e) {
      throw e;
    }
  }
}
