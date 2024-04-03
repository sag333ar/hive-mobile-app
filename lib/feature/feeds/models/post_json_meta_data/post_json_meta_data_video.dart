import 'package:hive_mobile_app/core/utilities/save_convert.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_json_meta_data/postJsonMetaDataVideoInfo';

class PostJsonVideo {
  final PostJsonVideoInfo info;

  PostJsonVideo({
    required this.info,
  });

  factory PostJsonVideo.fromJson(Map<String, dynamic>? json) => PostJsonVideo(
        info: PostJsonVideoInfo.fromJson(
          asMap(json, 'info'),
        ),
      );
}