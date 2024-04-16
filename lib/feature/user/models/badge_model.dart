import 'dart:convert';

import 'package:hive_mobile_app/core/utilities/save_convert.dart';

class BadgeModel {
  final String name;
  final DateTime? createdAt;
  final String? reputation;
  final int? followers;
  final int? following;
  final String title;

  BadgeModel({
    required this.name,
    this.createdAt,
    this.reputation,
    this.followers,
    this.following,
    required this.title,
  });

  BadgeModel copyWith({
    String? name,
    DateTime? createdAt,
    String? reputation,
    int? followers,
    int? following,
    String? title,
  }) =>
      BadgeModel(
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        reputation: reputation ?? this.reputation,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        title: title ?? this.title,
      );

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
      name: asString(json, "name"),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      reputation: json["reputation"],
      followers: json["followers"],
      following: json["following"],
      title: asString(json, "title"));

  Map<String, dynamic> toJson() => {
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "reputation": reputation,
        "followers": followers,
        "following": following,
        "title": title,
      };

  static List<BadgeModel> fromRawJson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BadgeModel>((json) => BadgeModel.fromJson(json)).toList();
  }
}
