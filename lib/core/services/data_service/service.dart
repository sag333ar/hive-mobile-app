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

Future<String> _error() {
  return Future.value('error');
}
