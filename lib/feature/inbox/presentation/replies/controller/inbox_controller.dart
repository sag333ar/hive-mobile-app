import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/inbox/repository/inbox_repository.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class InboxController extends Controller<PostFeedModel> {
  final InboxRepository _repository = getIt<InboxRepository>();
  final String accountName;
  InboxController({required this.accountName}) {
    super.pageLimit = 30;
    super.setInitApi(
      () => _repository.getReplies(
        accountName,
        pageLimit,
      ),
    );
    super.setPaginationApi(
      () => _repository.getReplies(accountName, pageLimit,
          lastAuthor: items.last.author, lastPermlink: items.last.permlink),
    );
    super.setFilterCallBack(filter);
    super.init();
  }

  void ignoreAuthor(String authorName) {
    // _repository.addToIgnoredUsers(authorName);
    items = [...items]..removeWhere((e) => e.author == authorName);
    if (items.isEmpty) {
      viewState = ViewState.empty;
    }
    notifyListeners();
  }

  Future<void> filter()async {
    List<String> ignoredAuthors = _repository.readIgnoredUsers();
    items.removeWhere((e) => ignoredAuthors.contains(e.author));
  }
}
