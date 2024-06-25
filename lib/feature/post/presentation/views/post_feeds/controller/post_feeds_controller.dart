import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class PostFeedsController extends Controller<PostFeedModel> {
  final PostRepository _repository = getIt<PostRepository>();
  final FeedType feedType;
  PostFeedsController({required this.feedType}) {
    setInitApi(() => _repository.getFeeds(feedType));
    super.init();
  }
}
