class CommunitySubscribersListNavigationModel {
  final String communityId;
  final bool removeScaffold;
  final int count;

  CommunitySubscribersListNavigationModel(
      {required this.communityId,
      required this.removeScaffold,
      required this.count});

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'removeScaffold': removeScaffold,
      'count': count
    };
  }
}
