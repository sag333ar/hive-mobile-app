import 'dart:convert';

import 'package:hive_mobile_app/core/utilities/save_convert.dart';

class CommunityModel {
    final String? about;
    final List<String> admins;
    final String? avatarUrl;
    final DateTime createdAt;
    final int id;
    final bool? isNsfw;
    final String? lang;
    final String name;
    final int? numAuthors;
    final int? numPending;
    final int? subscribers;
    final int? sumPending;
    final String title;
    final int? typeId;
    final String avatarUrlL;

    CommunityModel({
        this.about,
        this.admins = const [],
        this.avatarUrl,
        required this.createdAt,
        required this.id,
        this.isNsfw,
        this.lang,
        required this.name,
        this.numAuthors,
        this.numPending,
        this.subscribers,
        this.sumPending,
        required this.title,
        this.typeId,
        this.avatarUrlL = "",
    });

    CommunityModel copyWith({
        String? about,
        List<String>? admins,
        String? avatarUrl,
        DateTime? createdAt,
        int? id,
        bool? isNsfw,
        String? lang,
        String? name,
        int? numAuthors,
        int? numPending,
        int? subscribers,
        int? sumPending,
        String? title,
        int? typeId,
        String? avatarUrlL,
    }) => 
        CommunityModel(
            about: about ?? this.about,
            admins: admins ?? this.admins,
            avatarUrl: avatarUrl ?? this.avatarUrl,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
            isNsfw: isNsfw ?? this.isNsfw,
            lang: lang ?? this.lang,
            name: name ?? this.name,
            numAuthors: numAuthors ?? this.numAuthors,
            numPending: numPending ?? this.numPending,
            subscribers: subscribers ?? this.subscribers,
            sumPending: sumPending ?? this.sumPending,
            title: title ?? this.title,
            typeId: typeId ?? this.typeId,
            avatarUrlL: avatarUrlL ?? this.avatarUrlL,
        );

    factory CommunityModel.fromRawJson(String str) => CommunityModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
        about: asString(json, "about"),
        admins: json["admins"] == null ? [] : List<String>.from(json["admins"]!.map((x) => x)),
        avatarUrl: asString(json,"avatar_url"),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        isNsfw: json["is_nsfw"],
        lang: json["lang"],
        name: asString(json, "name"),
        numAuthors: json["num_authors"],
        numPending: json["num_pending"],
        subscribers: json["subscribers"],
        sumPending: json["sum_pending"],
        title: asString(json, "title"),
        typeId: json["type_id"],
        avatarUrlL: asString(json,"avatar_url")
    );

    Map<String, dynamic> toJson() => {
        "about": about,
        "admins": List<dynamic>.from(admins.map((x) => x)),
        "avatar_url": avatarUrl,
        "created_at": createdAt.toIso8601String(),
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
        "avatar_url l": avatarUrlL,
    };
}


