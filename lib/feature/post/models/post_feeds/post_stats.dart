import 'package:hive_mobile_app/core/utilities/save_convert.dart';

class PostStats {
  final bool? hide;
  final bool? gray;
  final int? totalVotes;
  final double? flagWeight;

  PostStats({
    this.hide = false,
    this.gray = false,
    this.totalVotes = 0,
    this.flagWeight = 0.0,
  });

  factory PostStats.fromJson(Map<String, dynamic>? json) => PostStats(
        hide: asBool(json, 'hide'),
        gray: asBool(json, 'gray'),
        totalVotes: asInt(json, 'total_votes'),
        flagWeight: asDouble(json, 'flag_weight'),
      );
}