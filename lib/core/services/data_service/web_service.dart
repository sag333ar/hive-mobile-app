
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
external dynamic getListOfCommunities(identifier, limit,lastName);

Future<String> getListOfCommunitiesFromPlatform(int limit,String? lastName) async {
  final String id = 'getListOfCommunities${DateTime.now().toIso8601String()}';
  var promise = getListOfCommunities(id, limit,lastName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external dynamic getWitnesses(identifier, limit,lastName);

Future<String> getWitnessesFromPlatform(int limit,String? lastName) async {
  final String id = 'getWitnesses${DateTime.now().toIso8601String()}';
  var promise = getWitnesses(id, limit,lastName);
  var contentData = await promiseToFuture(promise);
  return contentData;
}
