import 'dart:convert';
import 'package:hive_mobile_app/models/chain_prop_model.dart';
import 'package:hive_mobile_app/models/feed/post_feed_model.dart';
import 'package:hive_mobile_app/models/feed/post_feed_response_model.dart';
import 'package:hive_mobile_app/resources/enum.dart';
import 'package:hive_mobile_app/services/service.dart'
    if (dart.library.io) 'package:hive_mobile_app/services/mobile_service.dart'
    if (dart.library.html) 'package:hive_mobile_app/services/web_service.dart';

class ApiService {
  Future<ChainPropModel> getChainProps() async {
    String responseJson = await getChainPropsFromPlatform();
    ChainPropResponseModel response =
        ChainPropResponseModel.fromJson(json.decode(responseJson));
    if (response.type != 'getChainProps') {
      throw ('Error - Type does not match');
    } else if (response.errorMessage != "") {
      throw (response.errorMessage);
    }
    return response.data;
  }

  Future<List<PostFeedModel>> getFeed(FeedType type) async {
    String responseJson = await getFeedTypeFromPlatform(type);
    PostFeedResponseModel response =
        PostFeedResponseModel.fromJson(json.decode(responseJson));
    if (response.type != 'getFeed') {
      throw ('Error - Type does not match');
    } else if (response.errorMessage != "") {
      throw (response.errorMessage);
    }
    return response.data;
  }
}
