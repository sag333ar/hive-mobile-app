import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/community/repository/community_repository.dart';

class CommunityListController extends Controller<CommunityModel> {
  final CommunityRepository _repository = getIt<CommunityRepository>();
  CommunityListController() {
    super.pageLimit = 50;
    super.setInitApi(
      () => _repository.getListOfCommunities(
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getListOfCommunities(pageLimit,
          lastName: items.lastOrNull?.name),
    );
    super.init();
  }
}
