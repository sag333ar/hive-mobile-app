import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/services/local_service.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/inbox/models/inbox_model.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class InboxRepository {
  final ApiService _apiService;
  final LocalService _localService;

  InboxRepository(
      {required ApiService apiService, required LocalService localService})
      : _apiService = apiService,
        _localService = localService;

  Future<ActionListDataResponse<PostFeedModel>> getReplies(
      String accountName, int limit,
      {String? lastAuthor, String? lastPermlink}) async {
    return await _apiService.getAccountPosts(
        accountName, AccountPostType.replies, limit, lastAuthor, lastPermlink);
  }

  List<String> readIgnoredUsers() {
    return _localService.readIgnoredUsers();
  }

  Future<void> addToIgnoredUsers(String authorName) async {
    return await _localService.addToIgnoredUsers(authorName);
  }

  Future<ActionSingleDataResponse<InboxModel>> readInboxData(
      String token) async {
    return await _apiService.readInboxData(token);
  }

   Future<ActionSingleDataResponse<InboxModel>> writeInboxData(
      String token,InboxModel data) async {
    return await _apiService.writeInboxData(token,data);
  }
}
