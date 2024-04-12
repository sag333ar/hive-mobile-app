import 'dart:developer';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/repository/community_repository.dart';

class CommunitySubscribersListController extends Controller<CommunityMemberModel> {
  final CommunityRepository _repository = getIt<CommunityRepository>();
  final String communityId;
  CommunitySubscribersListController({required this.communityId}) {
    log('message');
    super.pageLimit = 50;
    super.setInitApi(
      () => _repository.getCommunitySubscribers(
        communityId,
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getCommunitySubscribers(communityId, pageLimit,
          lastName: items.last.name),
    );
    super.init();
  }
}
