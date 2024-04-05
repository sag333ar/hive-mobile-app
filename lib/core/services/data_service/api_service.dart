import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/models/chain_prop_model.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/services/data_service/service.dart'
    if (dart.library.io) 'package:hive_mobile_app/core/services/data_service/mobile_service.dart'
    if (dart.library.html) 'package:hive_mobile_app/core/services/data_service/web_service.dart';

class ApiService {
  Future<ActionSingleDataResponse<ChainPropModel>> getChainProps() async {
    try {
      String jsonString = await getChainPropsFromPlatform();
      ActionSingleDataResponse<ChainPropModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, (json) => ChainPropModel.fromJson(json!));
      return response;
    } catch (e) {
      return ActionSingleDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<PostFeedModel>> getFeed(FeedType type) async {
    try {
      String jsonString = await getFeedTypeFromPlatform(type);
      ActionListDataResponse<PostFeedModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => PostFeedModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<CommunityModel>> getListOfCommunities(
      int limit, String? lastName) async {
    try {
      String jsonString =
          await getListOfCommunitiesFromPlatform(limit, lastName);
      ActionListDataResponse<CommunityModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => CommunityModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<WitnessesModel>> getWitnesses(
      int limit, String? lastName) async {
    try {
      String jsonString =
          await getWitnessesFromPlatform(limit, lastName);
      ActionListDataResponse<WitnessesModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => WitnessesModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }
}
