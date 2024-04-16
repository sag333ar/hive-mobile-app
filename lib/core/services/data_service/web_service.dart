// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'package:js/js.dart';
import 'dart:js_util';
import 'package:hive_mobile_app/core/utilities/enum.dart';

@JS()
external dynamic getChainProps(identifier);

Future<String> getChainPropsFromPlatform() async {
  final String chainPropId =
      'getChainProps_${DateTime.now().toIso8601String()}';
  var promise = getChainProps(chainPropId);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getFeed(identifier, type);

Future<String> getFeedTypeFromPlatform(FeedType feedType) async {
  final String feedId = 'getFeed_${DateTime.now().toIso8601String()}';
  var promise = getFeed(feedId, enumToString(feedType));
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getListOfCommunities(identifier, limit, lastName);

Future<String> getListOfCommunitiesFromPlatform(
    int limit, String? lastName) async {
  final String id = 'getListOfCommunities${DateTime.now().toIso8601String()}';
  var promise = getListOfCommunities(id, limit, lastName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getWitnesses(identifier, limit, lastName);

Future<String> getWitnessesFromPlatform(int limit, String? lastName) async {
  final String id = 'getWitnesses${DateTime.now().toIso8601String()}';
  var promise = getWitnesses(id, limit, lastName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getProposals(identifier, limit);

Future<String> getProposalsFromPlatform(int limit) async {
  final String id = 'getProposals${DateTime.now().toIso8601String()}';
  var promise = getProposals(id, limit);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getFollowCount(identifier, accountName);

Future<String> getFollowCountFromPlatform(String accountName) async {
  final String id = 'getFollowCount${DateTime.now().toIso8601String()}';
  var promise = getFollowCount(id, accountName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getAccountInfo(identifier, accountName);

Future<String> getAccountInfoFromPlatform(String accountName) async {
  final String id = 'getAccountInfo${DateTime.now().toIso8601String()}';
  var promise = getAccountInfo(id, accountName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getFollowing(identifier, accountName, lastName, limit);

Future<String> getFollowingFromPlatform(
    String accountName, String? lastName, int limit) async {
  final String id = 'getFollowing${DateTime.now().toIso8601String()}';
  var promise = getFollowing(id, accountName, lastName, limit);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getFollowers(identifier, accountName, lastName, limit);

Future<String> getFollowersFromPlatform(
    String accountName, String? lastName, int limit) async {
  final String id = 'getFollowers${DateTime.now().toIso8601String()}';
  var promise = getFollowers(id, accountName, lastName, limit);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getAccountPosts(
    identifier, accountName, type, lastAuthor, lastPermlink, limit);

Future<String> getAccountPostsFromPlatform(String accountName, String type,
    String? lastAuthor, String? lastPermlink, int limit) async {
  final String id = 'getAccountPosts${DateTime.now().toIso8601String()}';
  var promise =
      getAccountPosts(id, accountName, type, lastAuthor, lastPermlink, limit);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getCommunityDetails(identifier, communityId);

Future<String> getCommunityDetailsFromPlatform(String communityId) async {
  final String id = 'getCommunityDetails${DateTime.now().toIso8601String()}';
  var promise = getCommunityDetails(id, communityId);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getCommunityFeed(
    identifier, communityId, type, lastAuthor, lastPermlink, limit);

Future<String> getCommunityFeedFromPlatform(String communityId, String type,
    String? lastAuthor, String? lastPermlink, int limit) async {
  final String id = 'getCommunityFeed${DateTime.now().toIso8601String()}';
  var promise =
      getCommunityFeed(id, communityId, type, lastAuthor, lastPermlink, limit);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getCommunitySubscribers(identifier, communityId,limit,lastName);

Future<String> getCommunitySubscribersFromPlatform(String communityId,int limit,String? lastName) async {
  final String id = 'getCommunitySubscribers${DateTime.now().toIso8601String()}';
  var promise = getCommunitySubscribers(id, communityId,limit,lastName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getSubscribedCommunities(identifier, accountName);

Future<String> getSubscribedCommunitiesFromPlatform(String accountName) async {
  final String id = 'getSubscribedCommunities${DateTime.now().toIso8601String()}';
  var promise = getSubscribedCommunities(id, accountName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}
