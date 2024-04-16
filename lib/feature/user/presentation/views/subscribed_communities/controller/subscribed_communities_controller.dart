import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';
import 'package:hive_mobile_app/feature/user/repository/user_repository.dart';

class SubscribedCommunitiesController
    extends Controller<SubscribedCommunityModel> {
  final UserRepository _repository = getIt<UserRepository>();
  final String accountName;
  SubscribedCommunitiesController({required this.accountName}) {
    super.pageLimit = 30;
    super.setInitApi(
      () => _repository.getSubscribedCommunities(
        accountName,
      ),
    );
    super.init();
  }
}
