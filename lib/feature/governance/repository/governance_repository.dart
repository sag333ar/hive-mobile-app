import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';

class GovernanceRepository {
  final ApiService _apiService;

  GovernanceRepository({required ApiService apiService}) : _apiService = apiService;

   Future<ActionListDataResponse<WitnessesModel>> getWitnesses(int limit,{String? lastName}) async {
    return await _apiService.getWitnesses(limit, lastName);
  }

  Future<ActionListDataResponse<ProposalModel>> getProposals(int limit) async {
    return await _apiService.getProposals(limit);
  }
}
