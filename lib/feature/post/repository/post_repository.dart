import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
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
}
