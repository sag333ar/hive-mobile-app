import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_detail/post_detail_model.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class PostRepository {
  final ApiService _apiService;

  PostRepository({required ApiService apiService}) : _apiService = apiService;

  Future<ActionListDataResponse<PostFeedModel>> getFeeds(FeedType type) async {
    return await _apiService.getFeed(type);
  }

  Future<ActionListDataResponse<PostFeedModel>> getAccountPosts(
      String accountName, AccountPostType type, int limit,
      {String? lastAuthor, String? lastPermlink}) async {
    return await _apiService.getAccountPosts(
        accountName, type, limit, lastAuthor, lastPermlink);
  }

  Future<ActionListDataResponse<PostFeedModel>> getCommunityFeed(
      String communityId, FeedType type, int limit,
      {String? lastAuthor, String? lastPermlink}) async {
    return await _apiService.getCommunityFeed(
        communityId, type, limit, lastAuthor, lastPermlink);
  }

  Future<String> getHtml(String inputString, int width) async {
    return await _apiService.getHtml(inputString, width);
  }

  Future<ActionSingleDataResponse<PostDetailModel>> getPostDetail(
      String accountName, String permlink) async {
    return await _apiService.getPostDetail(accountName, permlink);
  }

  Future<ActionListDataResponse<PostFeedModel>> getcomments(
      String accountName, String permlink) async {
    return await _apiService.getComments(accountName, permlink);
  }
}
