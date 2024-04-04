import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';

class CommunityRepository {
  final ApiService _apiService;

  CommunityRepository({required ApiService apiService}) : _apiService = apiService;

  Future<ActionListDataResponse<CommunityModel>> getListOfCommunities(int limit,{String? lastName}) async {
    return await _apiService.getListOfCommunities(limit, lastName);
  }
}
