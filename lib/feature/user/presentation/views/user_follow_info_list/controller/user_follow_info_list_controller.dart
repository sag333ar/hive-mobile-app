import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class UserFollowInfoListController extends Controller<FollowInfoModel> {
  final UserRepository _repository = getIt<UserRepository>();
  final FollowType type;
  final String accountName;
  UserFollowInfoListController(
      {required this.type, required this.accountName}) {
    super.pageLimit = 50;
    super.setInitApi(() => type == FollowType.followers
        ? _repository.getFollowers(
            accountName,
            pageLimit,
          )
        : _repository.getFollowing(
            accountName,
            pageLimit,
          ));
    super.setPaginationApi(() => type == FollowType.followers
        ? _repository.getFollowers(accountName, pageLimit,
            lastName: items.last.follower)
        : _repository.getFollowing(accountName, pageLimit,
            lastName: items.last.following));
    super.init();
  }
}
