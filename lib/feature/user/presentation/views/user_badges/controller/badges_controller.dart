import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/user/models/badge_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class UserBadgesController extends Controller<BadgeModel> {
  final UserRepository _repository = getIt<UserRepository>();
  final String accountName;
  UserBadgesController({required this.accountName}) {
    super.pageLimit = 30;
    super.setInitApi(
      () => _repository.getUserBadges(
        accountName,
      ),
    );
    super.init();
  }
}
