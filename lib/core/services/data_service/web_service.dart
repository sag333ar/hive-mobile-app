// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:js_util';
import 'package:hive_mobile_app/core/utilities/enum.dart';


@JS()
external getChainProps(identifier);
Future<String> getChainPropsFromPlatform() async {
  final String chainPropId =
      'getChainProps_${DateTime.now().toIso8601String()}';
  var promise = getChainProps(chainPropId);
  var contentData = await promiseToFuture(promise);
  return contentData;
}

@JS()
external getFeed(identifier, type);
Future<String> getFeedTypeFromPlatform(FeedType feedType) async {
  final String feedId = 'getFeed_${DateTime.now().toIso8601String()}';
  var promise = getFeed(feedId, enumToString(feedType));
  var contentData = await promiseToFuture(promise);
  return contentData;
}
