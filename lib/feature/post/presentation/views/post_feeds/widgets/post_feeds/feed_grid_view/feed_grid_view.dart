import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/controller/post_feeds_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_grid_view/feed_item_for_grid_view.dart';
import 'package:provider/provider.dart';

class FeedGridView extends StatelessWidget {
  const FeedGridView(
      {super.key,
      this.pageLoader,
      required this.items,
      this.isSliver = false,
      this.decrementedWidth});

  final Widget? pageLoader;
  final List<PostFeedModel> items;
  final bool isSliver;
  final double? decrementedWidth;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      isSliver: isSliver,
      decrementedWidth: decrementedWidth,
      childAspectRatio: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      itemCount: items.length,
      itemBuilder: (context, index) {
        PostFeedModel item = items[index];
        return FeedItemForGridView(
          item: item,
        );
      },
      paginationLoader: !isSliver
          ? PaginationLoader(
              pageVisibilityListener: (context) =>
                  context.select<PostFeedsController, bool>(
                      (value) => value.isNextPageLoading),
            )
          : null,
    );
  }
}
