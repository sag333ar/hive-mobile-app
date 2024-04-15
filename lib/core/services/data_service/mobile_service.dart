import 'package:flutter/services.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';

const String channel = 'app.the-hive-mobile/bridge';
const platform = MethodChannel(channel);

Future<String> getChainPropsFromPlatform() async {
  final String chainPropId =
      'getChainProps_${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getChainProps', {
    'id': chainPropId,
  });
  return response;
}

Future<String> getFeedTypeFromPlatform(FeedType feedType) async {
  final String feedId = 'getFeed_${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getFeed', {
    'id': feedId,
    'feed_type': enumToString(feedType), // trending, hot, created
  });
  return response;
}

Future<String> getListOfCommunitiesFromPlatform(
    int limit, String? lastName) async {
  final String id = 'getListOfCommunities${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod(
      'getListOfCommunities', {'id': id, 'limit': limit, 'lastName': lastName});
  return response;
}

Future<String> getWitnessesFromPlatform(int limit, String? lastName) async {
  final String id = 'getWitnesses${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod(
      'getWitnesses', {'id': id, 'limit': limit, 'lastName': lastName});
  return response;
}

Future<String> getProposalsFromPlatform(int limit) async {
  final String id = 'getProposals${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getProposals', {
    'id': id,
    'limit': limit,
  });
  return response;
}

Future<String> getFollowCountFromPlatform(String accountName) async {
  final String id = 'getFollowCount${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getFollowCount', {
    'id': id,
    'accountName': accountName,
  });
  return response;
}

Future<String> getAccountInfoFromPlatform(String accountName) async {
  final String id = 'getAccountInfo${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getAccountInfo', {
    'id': id,
    'accountName': accountName,
  });
  return response;
}

Future<String> getFollowingFromPlatform(
    String accountName, String? lastName, int limit) async {
  final String id = 'getFollowing${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getFollowing', {
    'id': id,
    'accountName': accountName,
    'lastName': lastName,
    'limit': limit
  });
  return response;
}

Future<String> getFollowersFromPlatform(
    String accountName, String? lastName, int limit) async {
  final String id = 'getFollowers${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getFollowers', {
    'id': id,
    'accountName': accountName,
    'lastName': lastName,
    'limit': limit
  });
  return response;
}

Future<String> getAccountPostsFromPlatform(String accountName, String type,
    String? lastAuthor, String? lastPermlink, int limit) async {
  final String id = 'getAccountPosts${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getAccountPosts', {
    'id': id,
    'accountName': accountName,
    'type': type,
    'lastAuthor': lastAuthor,
    'lastPermlink': lastPermlink,
    'limit': limit
  });
  return response;
}

Future<String> getCommunityDetailsFromPlatform(String communityId) async {
  final String id = 'getCommunityDetails${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getCommunityDetails', {
    'id': id,
    'communityId': communityId,
  });
  return response;
}

Future<String> getCommunityFeedFromPlatform(String communityId, String type,
    String? lastAuthor, String? lastPermlink, int limit) async {
  final String id = 'getCommunityFeed${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getCommunityFeed', {
    'id': id,
    'communityId': communityId,
    'type': type,
    'lastAuthor': lastAuthor,
    'lastPermlink': lastPermlink,
    'limit': limit
  });
  return response;
}

Future<String> getCommunitySubscribersFromPlatform(String communityId,int limit,String? lastName) async {
  final String id = 'getCommunitySubscribers${DateTime.now().toIso8601String()}';
  final String response = await platform.invokeMethod('getCommunitySubscribers', {
    'id': id,
    'communityId': communityId,
    'limit': limit,
    'lastName': lastName
  });
  return response;
}
