import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';

class FeedsRepository {
  final ApiService _apiService;

  FeedsRepository({required ApiService apiService}) : _apiService = apiService;

  Future<ActionListDataResponse<PostFeedModel>> getFeeds(FeedType type) async {
    return await _apiService.getFeed(type);
  }
}
