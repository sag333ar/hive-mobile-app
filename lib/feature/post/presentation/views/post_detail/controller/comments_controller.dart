import 'package:flutter/foundation.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/models/action_response.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/generics/controllers/controller_interface.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class CommentsController extends ChangeNotifier
    implements ControllerInterface<PostFeedModel> {
  final PostRepository _repository = getIt<PostRepository>();
  final String accountName;
  final String permlink;
  @override
  List<PostFeedModel> items = [];

  @override
  ViewState viewState = ViewState.loading;

  CommentsController({
    required this.accountName,
    required this.permlink,
  }) {
    init();
  }

  @override
  void init() async {
    ActionListDataResponse<PostFeedModel> response =
        await _repository.getcomments(accountName, permlink);
    if (response.isSuccess && response.data != null) {
      viewState = ViewState.data;
      items = response.data!;
      items = refactorComments(items, permlink);
    } else {
      viewState = ViewState.error;
    }
    notifyListeners();
  }

  @override
  void loadNextPage() {
    // TODO: implement loadNextPage
  }

  @override
  void refresh() {
    viewState = ViewState.loading;
    notifyListeners();
    init();
  }

  List<PostFeedModel> refactorComments(
      List<PostFeedModel> content, String parentPermlink) {
    List<PostFeedModel> refactoredComments = [];
    var newContent = List<PostFeedModel>.from(content);
    for (var e in newContent) {
      e = e.copyWith(visited: false);
    }
    _sortList(newContent);
    refactoredComments.addAll(
        newContent.where((e) => e.parentPermlink == parentPermlink).toList());
    while (refactoredComments.where((e) => e.visited == false).isNotEmpty) {
      var firstComment =
          refactoredComments.where((e) => e.visited == false).first;
      var indexOfFirstElement = refactoredComments.indexOf(firstComment);
      if (firstComment.children != 0) {
        List<PostFeedModel> children = newContent
            .where((e) => e.parentPermlink == firstComment.permlink)
            .toList();
        children.sort((a, b) {
          var aTime = a.created;
          var bTime = b.created;
          if (aTime.isAfter(bTime)) {
            return -1;
          } else if (bTime.isAfter(aTime)) {
            return 1;
          } else {
            return 0;
          }
        });
        refactoredComments.insertAll(indexOfFirstElement + 1, children);
      }
      int index =
          refactoredComments.indexWhere((element) => element == firstComment);
      refactoredComments[index] = firstComment.copyWith(visited: true);
      // firstComment = ;
    }
    return refactoredComments;
  }

  void _sortList(List<PostFeedModel> list) {
    list.sort((a, b) {
      var bTime = b.created;
      var aTime = a.created;
      if (aTime.isAfter(bTime)) {
        return -1;
      } else if (bTime.isAfter(aTime)) {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
