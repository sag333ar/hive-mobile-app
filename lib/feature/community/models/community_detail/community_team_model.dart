class CommunityMemberModel {
  final String name;
  final String role;

  CommunityMemberModel({
    required this.name,
    required this.role,
  });

  factory CommunityMemberModel.fromJson(List list) => CommunityMemberModel(
        name: list.firstOrNull ?? "",
        role: list.length > 1 ? list[1] : "",
      );
}
