import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_feeds/controller/community_feed_controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_grid_view/feed_grid_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_list_view/feed_list_view.dart';
import 'package:provider/provider.dart';

class CommunityFeedViewWidget extends StatelessWidget {
  const CommunityFeedViewWidget(
      {super.key, required this.feedType, required this.communityId});

  final FeedType feedType;
  final String communityId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CommunityFeedController>();
    return Selector<CommunityFeedController, ViewState>(
      selector: (_, provider) => provider.viewState,
      builder: (context, value, child) {
        if (value == ViewState.data) {
          return _dataState(controller);
        } else if (value == ViewState.empty) {
          return const Emptystate(isSliver: true, text: 'No feeds found');
        } else if (value == ViewState.error) {
          return ErrorState(
            isSliver: true,
            showRetryButton: true,
            onTapRetryButton: () => controller.refresh(),
          );
        } else {
          return const LoadingState(
            isSliver: true,
          );
        }
      },
    );
  }

  Widget _dataState(CommunityFeedController controller) {
    return ScrollEndListener(
      loadNextPage: () => controller.loadNextPage(),
      child: Selector<CommunityFeedController, List<PostFeedModel>>(
        shouldRebuild: (previous, next) =>
            previous != next || previous.length != next.length,
        selector: (_, provider) => provider.items,
        builder: (context, items, child) {
          if (context.isMobileSize) {
            return FeedListView(
              items: items,
              isSliver: true,
            );
          } else if (context.isTabletSize) {
            return FeedGridView(
              decrementedWidth: 150,
              items: items,
              isSliver: true,
            );
          } else {
            return FeedGridView(
              decrementedWidth: 150,
              items: items,
              isSliver: true,
            );
          }
        },
      ),
    );
  }
}
