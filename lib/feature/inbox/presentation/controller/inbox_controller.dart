import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class InboxController extends Controller<PostFeedModel> {
  final PostRepository _repository = getIt<PostRepository>();
  final String accountName;
  InboxController({ required this.accountName}) {
    super.pageLimit = 30;
    super.setInitApi(
      () => _repository.getAccountPosts(
        accountName,
        AccountPostType.replies,
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getAccountPosts(accountName, AccountPostType.replies, pageLimit,
          lastAuthor: items.last.author, lastPermlink: items.last.permlink),
    );
    super.init();
  }
}