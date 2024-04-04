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
  final String feedResponse = await platform.invokeMethod('getFeed', {
    'id': feedId,
    'feed_type': enumToString(feedType), // trending, hot, created
  });
  return feedResponse;
}

Future<String> getListOfCommunitiesFromPlatform(int limit,String? lastName)async{
   final String id = 'getListOfCommunities${DateTime.now().toIso8601String()}';
  final String feedResponse = await platform.invokeMethod('getListOfCommunities', {
    'id': id,
    'limit': limit, 
    'lastName': lastName
  });
  return feedResponse;
}
