class SubscribedCommunityModel {
  final String id;
  final String name;
  final String role;

  SubscribedCommunityModel({
    required this.id,
    required this.name,
    required this.role,
  });

  factory SubscribedCommunityModel.fromJson(List list) =>
      SubscribedCommunityModel(
        id: list.firstOrNull ?? "",
        name: list.length > 1 ? list[1] : "",
        role: list.length > 2 ? list[2] : "",
      );
}
