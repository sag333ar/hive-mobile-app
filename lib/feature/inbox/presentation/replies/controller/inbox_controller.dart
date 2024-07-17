import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller.dart';
import 'package:hive_mobile_app/feature/inbox/models/bookmark_model.dart';
import 'package:hive_mobile_app/feature/inbox/models/inbox_model.dart';
import 'package:hive_mobile_app/feature/inbox/models/prcocessed_comment_model.dart';
import 'package:hive_mobile_app/feature/inbox/repository/inbox_repository.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class InboxController extends Controller<PostFeedModel> {
  final InboxRepository _repository = getIt<InboxRepository>();
  final String accountName;
  final String token;

  InboxModel? inboxData;

  InboxController({required this.accountName, required this.token}) {
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
    InboxModel newData = inboxData!
        .copyWith(ignoredAuthors: [...inboxData!.ignoredAuthors, authorName]);
    _setUpdatedData(newData);
    items = [...items]..removeWhere((e) => e.author == authorName);
    if (items.isEmpty) {
      viewState = ViewState.empty;
    }
    notifyListeners();
  }

  void _setUpdatedData(InboxModel newData) {
    _repository.writeInboxData(token, newData);
    inboxData = newData;
  }

  bool isBookmarked(String authorName, String permlink) {
    return inboxData!.bookmarks.any((element) =>
        (element.author == authorName && element.permlink == permlink));
  }

  void toggleBookmark(bool isAdd, PostFeedModel data) {
    InboxModel newData;
    if (!isAdd) {
      newData = inboxData!.copyWith(
        bookmarks: [...inboxData!.bookmarks]..removeWhere((element) =>
            element.author == data.author && element.permlink == data.permlink),
      );
    } else {
      newData = inboxData!.copyWith(
        bookmarks: [
          ...inboxData!.bookmarks,
          BookmarkModel(
            body: data.body,
            title: data.title,
            author: data.author,
            permlink: data.permlink,
          )
        ],
      );
    }
    _setUpdatedData(newData);
  }

  void addToProcessedComments(String author, String permlink) {
    InboxModel newData = inboxData!.copyWith(
      processedComments: [
        ...inboxData!.processedComments,
        ProcessedCommentModel(
          author: author,
          permlink: permlink,
        )
      ],
    );
    _setUpdatedData(newData);
    items = [...items]
      ..removeWhere((e) => e.author == author && e.permlink == permlink);
    if (items.isEmpty) {
      viewState = ViewState.empty;
    }
    notifyListeners();
  }

  Future<void> filter() async {
    ActionSingleDataResponse<InboxModel> response =
        await _repository.readInboxData(token);
    if (response.isSuccess) {
      inboxData = response.data!;
      items.removeWhere((e) => (response.data!.ignoredAuthors
              .contains(e.author) ||
          response.data!.processedComments.any((comment) =>
              comment.author == e.author && comment.permlink == e.permlink)));
    } else {
      throw Exception("Inbox data fetch failed");
    }
  }
}
