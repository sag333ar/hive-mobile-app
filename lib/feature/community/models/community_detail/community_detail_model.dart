import 'dart:convert';

import 'package:hive_mobile_app/core/utilities/save_convert.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';

class CommunityDetailModel {
  final String about;
  final String? avatarUrl;
  final DateTime createdAt;
  final String? description;
  final String? flagText;
  final int id;
  final bool? isNsfw;
  final String lang;
  final String name;
  final int numAuthors;
  final int numPending;
  final int subscribers;
  final int sumPending;
  final List<CommunityMemberModel>? team;
  final String title;
  final int? typeId;
  final UserModel? community;

  CommunityDetailModel(
      {required this.about,
      this.avatarUrl,
      required this.createdAt,
      this.description,
      this.flagText,
      required this.id,
      this.isNsfw,
      required this.lang,
      required this.name,
      required this.numAuthors,
      required this.numPending,
      required this.subscribers,
      required this.sumPending,
      this.team,
      required this.title,
      this.typeId,
      this.community});

  CommunityDetailModel copyWith(
          {String? about,
          String? avatarUrl,
          DateTime? createdAt,
          String? description,
          String? flagText,
          int? id,
          bool? isNsfw,
          String? lang,
          String? name,
          int? numAuthors,
          int? numPending,
          int? subscribers,
          int? sumPending,
          List<CommunityMemberModel>? team,
          String? title,
          int? typeId,
          UserModel? community}) =>
      CommunityDetailModel(
          about: about ?? this.about,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          createdAt: createdAt ?? this.createdAt,
          description: description ?? this.description,
          flagText: flagText ?? this.flagText,
          id: id ?? this.id,
          isNsfw: isNsfw ?? this.isNsfw,
          lang: lang ?? this.lang,
          name: name ?? this.name,
          numAuthors: numAuthors ?? this.numAuthors,
          numPending: numPending ?? this.numPending,
          subscribers: subscribers ?? this.subscribers,
          sumPending: sumPending ?? this.sumPending,
          team: team ?? this.team,
          title: title ?? this.title,
          typeId: typeId ?? this.typeId,
          community: community ?? this.community);

  factory CommunityDetailModel.fromRawJson(String str) =>
      CommunityDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityDetailModel.fromJson(Map<String, dynamic> json) =>
      CommunityDetailModel(
        about: asString(json, "about"),
        avatarUrl: json["avatar_url"],
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
        flagText: json["flag_text"],
        id: asInt(json, "id"),
        isNsfw: json["is_nsfw"],
        lang: asString(json, "lang"),
        name: asString(json, "name"),
        numAuthors: asInt(json, "num_authors"),
        numPending: asInt(json, "num_pending"),
        subscribers: asInt(json, "subscribers"),
        sumPending: asInt(json, "sum_pending"),
        team: json["team"] == null
            ? []
            : (json["team"] as List<dynamic>)
                .map((dynamic item) =>
                    CommunityMemberModel.fromJson(item as List))
                .toList(),
        title: asString(json, "title"),
        typeId: json["type_id"],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "avatar_url": avatarUrl,
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "flag_text": flagText,
        "id": id,
        "is_nsfw": isNsfw,
        "lang": lang,
        "name": name,
        "num_authors": numAuthors,
        "num_pending": numPending,
        "subscribers": subscribers,
        "sum_pending": sumPending,
        "title": title,
        "type_id": typeId,
      };
}
