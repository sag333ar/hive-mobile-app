import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:hive_mobile_app/feature/governance/repository/governance_repository.dart';

class ProposalController extends Controller<ProposalModel> {
  final GovernanceRepository _repository = getIt<GovernanceRepository>();

   ProposalController() {
    super.pageLimit = 50;
    super.setInitApi(
      () => _repository.getProposals(
        pageLimit,
      ),
    );
    super.init();
  }
}
