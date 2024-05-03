import 'package:hive_mobile_app/core/utilities/enum.dart';

Future<String> getChainPropsFromPlatform() {
  return _error();
}

Future<String> getFeedTypeFromPlatform(FeedType feedType) {
  return _error();
}

Future<String> getListOfCommunitiesFromPlatform(int limit, String? lastName) {
  return _error();
}

Future<String> getWitnessesFromPlatform(int limit, String? lastName) {
  return _error();
}

Future<String> getProposalsFromPlatform(
  int limit,
) {
  return _error();
}

Future<String> getFollowCountFromPlatform(String accountName) {
  return _error();
}

Future<String> getAccountInfoFromPlatform(String accountName) {
  return _error();
}

Future<String> getFollowingFromPlatform(
    String accountName, String? lastName, int limit) {
  return _error();
}

Future<String> getFollowersFromPlatform(
    String accountName, String? lastName, int limit) {
  return _error();
}

Future<String> getAccountPostsFromPlatform(String accountName, String type,
    String? lastAuthor, String? lastPermlink, int limit) {
  return _error();
}

Future<String> getCommunityDetailsFromPlatform(String communityId) {
  return _error();
}

Future<String> getCommunityFeedFromPlatform(String communityId, String type,
    String? lastAuthor, String? lastPermlink, int limit) {
  return _error();
}

Future<String> getCommunitySubscribersFromPlatform(
    String communityId, int limit, String? lastName) {
  return _error();
}

Future<String> getSubscribedCommunitiesFromPlatform(String accountName) {
  return _error();
}

Future<String> getGlobalChainPropertiesFromPlatform() {
  return _error();
}

Future<String> getAccountHistoryFromPlatform(
    String accountName, int startId, int limit, String filters) {
  return _error();
}

Future<String> _error() {
  return Future.value('error');
}
