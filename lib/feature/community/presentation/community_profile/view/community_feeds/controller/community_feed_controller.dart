import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class CommunityFeedController extends Controller<PostFeedModel> {
  final PostRepository _repository = getIt<PostRepository>();
  final FeedType feedType;
  final String communityId;
  CommunityFeedController({required this.feedType, required this.communityId}) {
    super.pageLimit = 30;
    super.setInitApi(
      () => _repository.getCommunityFeed(
        communityId,
        feedType,
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getCommunityFeed(communityId, feedType, pageLimit,
          lastAuthor: items.last.author, lastPermlink: items.last.permlink),
    );
    super.init();
  }
}
