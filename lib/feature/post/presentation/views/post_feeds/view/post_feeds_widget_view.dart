import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/controller/post_feeds_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_grid_view/feed_grid_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_list_view/feed_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostFeedsWidgetView extends StatefulWidget {
  const PostFeedsWidgetView({super.key, required this.feedType});

  final FeedType feedType;

  @override
  State<PostFeedsWidgetView> createState() => _PostFeedsWidgetViewState();
}

class _PostFeedsWidgetViewState extends State<PostFeedsWidgetView>
    with AutomaticKeepAliveClientMixin {
  late final PostFeedsController controller;

  @override
  void initState() {
    controller = PostFeedsController(feedType: widget.feedType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        return Selector<PostFeedsController, ViewState>(
          selector: (_, provider) => provider.viewState,
          builder: (context, value, child) {
            if (value == ViewState.data) {
              return _dataState();
            } else if (value == ViewState.empty) {
              return const Emptystate(
                  icon: Icons.hourglass_empty, text: 'No feeds found');
            } else if (value == ViewState.error) {
              return ErrorState(
                showRetryButton: true,
                onTapRetryButton: () => controller.refresh(),
              );
            } else {
              return const LoadingState();
            }
          },
        );
      },
    );
  }

  Widget _dataState() {
    return Selector<PostFeedsController, List<PostFeedModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return ScrollEndListener(
          loadNextPage: () => {},
          child: ScreenTypeLayout.builder(
            mobile: (_) => FeedListView(
              items: items,
            ),
            tablet: (_) => FeedGridView(
                pageLoader: const SizedBox.shrink(),
                items: items,),
            desktop: (_) => FeedGridView(
                pageLoader: const SizedBox.shrink(),
                items: items,),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
