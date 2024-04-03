import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/controller/home_feed_controller.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/feed_grid_view/feed_grid_view.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/feed_list_view/feed_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeFeedWidget extends StatefulWidget {
  const HomeFeedWidget({super.key, required this.feedType});

  final FeedType feedType;

  @override
  State<HomeFeedWidget> createState() => _HomeFeedWidgetState();
}

class _HomeFeedWidgetState extends State<HomeFeedWidget>
    with AutomaticKeepAliveClientMixin {
  late final HomeFeedController controller;

  @override
  void initState() {
    controller = HomeFeedController(feedType: widget.feedType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        return Selector<HomeFeedController, ViewState>(
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
    return Selector<HomeFeedController, List<PostFeedModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
            }
            return true;
          },
          child: ScreenTypeLayout.builder(
            mobile: (_) => FeedListView(
              items: items,
              feedType: widget.feedType,
            ),
            tablet: (_) => FeedGridView(
                pageLoader: const SizedBox.shrink(),
                items: items,
                feedType: widget.feedType),
            desktop: (_) => FeedGridView(
                pageLoader: const SizedBox.shrink(),
                items: items,
                feedType: widget.feedType),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
