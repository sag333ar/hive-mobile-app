import 'package:hive_mobile_app/core/utilities/save_convert.dart';

class FollowInfoModel {
  final String follower;
  final String following;
  final List<String>? what;

  FollowInfoModel({
    required this.follower,
    required this.following,
    this.what,
  });

  FollowInfoModel copyWith({
    String? follower,
    String? following,
    List<String>? what,
  }) =>
      FollowInfoModel(
        follower: follower ?? this.follower,
        following: following ?? this.following,
        what: what ?? this.what,
      );

  factory FollowInfoModel.fromJson(Map<String, dynamic> json) =>
      FollowInfoModel(
        follower: asString(json, "follower"),
        following: asString(json, "following"),
        what: json["what"] == null
            ? []
            : List<String>.from(json["what"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "follower": follower,
        "following": following,
        "what": what == null ? [] : List<String>.from(what!.map((x) => x)),
      };
}
