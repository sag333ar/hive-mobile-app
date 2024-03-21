
import 'package:hive_mobile_app/resources/enum.dart';

Future<String> getChainPropsFromPlatform() {
  return _error();
}

Future<String> getFeedTypeFromPlatform(FeedType feedType) {
  return _error();
}

Future<String> _error() {
  return Future.value('error');
}
