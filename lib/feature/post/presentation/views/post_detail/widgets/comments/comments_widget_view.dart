import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/controller/comments_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/widgets/comments/comment_tile.dart';
import 'package:provider/provider.dart';

class CommentsWidgetView extends StatelessWidget {
  const CommentsWidgetView(
      {super.key, required this.author, required this.permlink});

  final String author;
  final String permlink;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentsController(
        accountName: author,
        permlink: permlink,
      ),
      builder: (context, child) {
        final controller = context.read<CommentsController>();
        return Selector<CommentsController, ViewState>(
          selector: (_, provider) => provider.viewState,
          builder: (context, value, child) {
            if (value == ViewState.data) {
              return _commentListView();
            } else if (value == ViewState.empty) {
              return const Emptystate(
                  isSliver: true,
                  icon: Icons.hourglass_empty,
                  text: 'No feeds found');
            } else if (value == ViewState.error) {
              return ErrorState(
                showRetryButton: true,
                isSliver: true,
                onTapRetryButton: () => controller.refresh(),
              );
            } else {
              return const LoadingState(
                isSliver: true,
              );
            }
          },
        );
      },
    );
  }

  Widget _commentListView() {
    return Selector<CommentsController, List<PostFeedModel>>(
      selector: (_, myType) => myType.items,
      builder: (context, items, child) {
        return SliverList.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CommentTile(item: items[index]);
          },
          separatorBuilder: (context, index) {
        bool commentDividerVisibility = true;
        commentDividerVisibility =
            _commentDividerVisibility(index, items, commentDividerVisibility);
        return Visibility(
          visible: commentDividerVisibility,
          child: const Divider(
            height: 10,
          ),
        );
      },
        );
      },
    );
  }

    bool _commentDividerVisibility(
      int index, List<PostFeedModel> items, bool drawLine) {
    if (index + 1 < items.length) {
      if ((items[index + 1].depth == 1)) {
        drawLine = true;
      } else {
        drawLine = false;
      }
    }
    return drawLine;
  }
}
