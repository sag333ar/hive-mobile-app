import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/repository/governance_repository.dart';

class WitnessController extends Controller<WitnessesModel> {
  final GovernanceRepository _repository = getIt<GovernanceRepository>();

   WitnessController() {
    super.pageLimit = 50;
    super.setInitApi(
      () => _repository.getWitnesses(
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getWitnesses(pageLimit,
          lastName: items.lastOrNull?.owner),
    );
    super.init();
  }
}
