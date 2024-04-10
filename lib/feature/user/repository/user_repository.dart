import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/feature/user/models/follow_count_model.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository({required ApiService apiService}) : _apiService = apiService;

  Future<ActionSingleDataResponse<UserModel>> getAccountInfo(
      String accountName) async {
    return await _apiService.getAccountInfo(accountName);
  }

  Future<ActionSingleDataResponse<FollowCountModel>> getFollowCount(
      String accountName) async {
    return await _apiService.getFollowCount(accountName);
  }

  Future<ActionListDataResponse<FollowInfoModel>> getFollowing(
      String accountName, int limit,
      {String? lastName}) async {
    return await _apiService.getFollowing(accountName, limit, lastName);
  }

  Future<ActionListDataResponse<FollowInfoModel>> getFollowers(
      String accountName, int limit,
      {String? lastName}) async {
    return await _apiService.getFollowers(accountName, limit, lastName);
  }
}
