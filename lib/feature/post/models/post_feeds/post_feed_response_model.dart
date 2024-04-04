// import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';

// class PostFeedResponseModel {
//   final String id;
//   final String type;
//   final List<PostFeedModel> data;
//   final bool valid;
//   final String errorMessage;

//   PostFeedResponseModel(
//       {required this.id,
//       required this.type,
//       required this.data,
//       required this.valid,
//       required this.errorMessage});
  
//    factory PostFeedResponseModel.fromJson(Map<String, dynamic> json) =>
//       PostFeedResponseModel(
//           id: json['id'],
//           type: json['type'],
//           data: PostFeedModel.fromRawJson(json['data']).map((e) => PostFeedModel.fromJson(e)).toList(),
//           valid: json['valid'],
//           errorMessage: json['error']);
// }
