import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class UserAccountHistoryController extends Controller<AccountHistoryModel> {
  final UserRepository _repository = getIt<UserRepository>();
  final String accountName;

  List<AccountHistoryType> filters = AccountHistoryType.values;

  UserAccountHistoryController({required this.accountName}) {
    super.pageLimit = 30;
    super.reverseData = true;
    super.setInitApi(
      () => _repository.getAccountHistory(accountName, pageLimit, filters),
    );
    super.setPaginationApi(
      () => _repository.getAccountHistory(accountName, pageLimit, filters,
          startId: items.last.id),
    );
    super.init();
  }
}
