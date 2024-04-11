import 'package:hive_mobile_app/core/utilities/save_convert.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_json_meta_data/post_json_meta_data_video.dart';

class PostJsonMetadata {
  final List<String>? tags;
  final List<String>? image;
  final List<String>? images;
  final List<String>? links;
  final List<String>? users;
  final String? app;
  final PostJsonVideo? video;
  final String? format;

  const PostJsonMetadata({
    required this.tags,
    required this.image,
    this.images = const [],
    this.app = "",
    this.format,
    this.links = const [],
    this.users = const [],
    required this.video,
  });

  factory PostJsonMetadata.fromJson(Map<String, dynamic>? json) =>
      PostJsonMetadata(
        tags: asList(json, 'tags').map((e) => e.toString()).toList(),
        image: _images(json),
        links: asList(json, 'links').map((e) => e.toString()).toList(),
        users: asList(json, 'users').map((e) => e.toString()).toList(),
        format: json?['format'] as String? ?? "",
        app: asString(json, 'app'),
        video: PostJsonVideo.fromJson(
          asMap(json, 'video'),
        ),
      );

  static List<String> _images(Map<String, dynamic>? json) {
    if (json?['image'] != null) {
      return asList(json, 'image').map((e) => e.toString()).toList();
    } else {
      return asList(json, 'images').map((e) => e.toString()).toList();
    }
  }
}
