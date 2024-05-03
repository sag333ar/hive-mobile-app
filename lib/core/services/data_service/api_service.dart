import 'dart:convert';
import 'dart:math' as math;
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/models/chain_prop_model.dart';
import 'package:hive_mobile_app/core/services/data_service/service.dart'
    if (dart.library.io) 'package:hive_mobile_app/core/services/data_service/mobile_service.dart'
    if (dart.library.html) 'package:hive_mobile_app/core/services/data_service/web_service.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_model.dart';
import 'package:hive_mobile_app/feature/user/models/badge_model.dart';
import 'package:hive_mobile_app/feature/user/models/follow_count_model.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/models/global_props_model.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ActionSingleDataResponse<ChainPropModel>> getChainProps() async {
    try {
      String jsonString = await getChainPropsFromPlatform();
      ActionSingleDataResponse<ChainPropModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, (json) => ChainPropModel.fromJson(json));
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
      String jsonString = await getWitnessesFromPlatform(limit, lastName);
      ActionListDataResponse<WitnessesModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => WitnessesModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<ProposalModel>> getProposals(int limit) async {
    try {
      String jsonString = await getProposalsFromPlatform(
        limit,
      );
      ActionListDataResponse<ProposalModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => ProposalModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionSingleDataResponse<FollowCountModel>> getFollowCount(
      String accountName) async {
    try {
      String jsonString = await getFollowCountFromPlatform(
        accountName,
      );
      ActionSingleDataResponse<FollowCountModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, FollowCountModel.fromJson);
      return response;
    } catch (e) {
      return ActionSingleDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionSingleDataResponse<UserModel>> getAccountInfo(
      String accountName) async {
    try {
      String jsonString = await getAccountInfoFromPlatform(
        accountName,
      );
      ActionSingleDataResponse<UserModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, UserModel.fromJson);
      return response;
    } catch (e) {
      return ActionSingleDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<FollowInfoModel>> getFollowing(
      String accountName, int limit, String? lastName) async {
    try {
      String jsonString =
          await getFollowingFromPlatform(accountName, lastName, limit);
      ActionListDataResponse<FollowInfoModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => FollowInfoModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<FollowInfoModel>> getFollowers(
      String accountName, int limit, String? lastName) async {
    try {
      String jsonString =
          await getFollowersFromPlatform(accountName, lastName, limit);
      ActionListDataResponse<FollowInfoModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => FollowInfoModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<PostFeedModel>> getAccountPosts(
      String accountName,
      AccountPostType type,
      int limit,
      String? lastAuthor,
      String? lastPermlink) async {
    try {
      String jsonString = await getAccountPostsFromPlatform(
          accountName, enumToString(type), lastAuthor, lastPermlink, limit);
      ActionListDataResponse<PostFeedModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => PostFeedModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<int> getUserReputation(String accountName) async {
    try {
      var headers = {
        'accept': 'application/json, text/plain, */*',
        'content-type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('https://api.hive.blog/'));
      request.body = json.encode({
        "id": 0,
        "jsonrpc": "2.0",
        "method": "condenser_api.get_account_reputations",
        "params": [accountName, 1]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return _parseAuthorReputation(
            (json.decode(jsonString)['result'][0]['reputation']));
      } else {
        throw 'failed';
      }
    } catch (e) {
      rethrow;
    }
  }

  int _parseAuthorReputation(int rawRep) {
    String rep = rawRep.toString();
    bool neg = rep.startsWith("-");
    rep = neg ? rep.substring(1) : rep;
    double out = math.log(int.parse(rep)) / math.log(10);
    if (out.isInfinite) out = 0;
    out = math.max(out - 9, 0);
    out = (neg ? -1 : 1) * out;
    out = out * 9 + 25;
    return out.toInt();
  }

  Future<ActionSingleDataResponse<CommunityDetailModel>> getCommunityDetails(
      String communityId) async {
    try {
      String jsonString = await getCommunityDetailsFromPlatform(
        communityId,
      );
      ActionSingleDataResponse<CommunityDetailModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, CommunityDetailModel.fromJson);
      return response;
    } catch (e) {
      return ActionSingleDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<PostFeedModel>> getCommunityFeed(
      String communityId,
      FeedType type,
      int limit,
      String? lastAuthor,
      String? lastPermlink) async {
    try {
      String jsonString = await getCommunityFeedFromPlatform(
          communityId, enumToString(type), lastAuthor, lastPermlink, limit);
      ActionListDataResponse<PostFeedModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => PostFeedModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<CommunityMemberModel>> getCommunitySubscribers(
      String communityId, int limit, String? lastName) async {
    try {
      String jsonString = await getCommunitySubscribersFromPlatform(
          communityId, limit, lastName);
      ActionListDataResponse<CommunityMemberModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => CommunityMemberModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<SubscribedCommunityModel>>
      getSubscribedCommunities(String accountName) async {
    try {
      String jsonString =
          await getSubscribedCommunitiesFromPlatform(accountName);
      ActionListDataResponse<SubscribedCommunityModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => SubscribedCommunityModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<BadgeModel>> getUserBadges(
      String accountName) async {
    final response = await http
        .get(Uri.parse('https://peakd.com/api/public/badge/$accountName'));
    if (response.statusCode == 200) {
      return ActionListDataResponse<BadgeModel>(
          data: BadgeModel.fromRawJson(response.body),
          status: ResponseStatus.success,
          isSuccess: true,
          errorMessage: "");
    } else {
      throw ActionListDataResponse<BadgeModel>(
          status: ResponseStatus.failed, errorMessage: "Server Error");
    }
  }

  Future<ActionSingleDataResponse<GlobalChainPropsModel>>
      getGlobalChainProperties() async {
    try {
      String jsonString = await getGlobalChainPropertiesFromPlatform();
      ActionSingleDataResponse<GlobalChainPropsModel> response =
          ActionSingleDataResponse.fromJsonString(
              jsonString, GlobalChainPropsModel.fromJson);
      return response;
    } catch (e) {
      return ActionSingleDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }

  Future<ActionListDataResponse<AccountHistoryModel>> getAccountHistory(
      String accountName,
      int startId,
      int limit,
      List<AccountHistoryType> filters) async {
    try {
      String filterInString = json.encode(
          filters.map((enumValue) => enumToString(enumValue)).toList());
      String jsonString = await getAccountHistoryFromPlatform(
          accountName, startId, limit, filterInString);
      ActionListDataResponse<AccountHistoryModel> response =
          ActionListDataResponse.fromJsonString(
              jsonString, (item) => AccountHistoryModel.fromJson(item));
      return response;
    } catch (e) {
      return ActionListDataResponse(
          status: ResponseStatus.failed, errorMessage: e.toString());
    }
  }
}
