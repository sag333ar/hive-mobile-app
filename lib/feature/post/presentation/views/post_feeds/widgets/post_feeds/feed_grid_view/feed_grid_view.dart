import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/controller/post_feeds_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_grid_view/feed_item_for_grid_view.dart';
import 'package:provider/provider.dart';

class FeedGridView extends StatelessWidget {
  const FeedGridView(
      {super.key,
      required this.pageLoader,
      required this.items,
      required this.feedType});

  final Widget pageLoader;
  final List<PostFeedModel> items;
  final FeedType feedType;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      childAspectRatio: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      itemCount: items.length,
      itemBuilder: (context, index) {
        PostFeedModel item = items[index];
        return FeedItemForGridView(
          feedType: feedType,
          item: item,
        );
      },
       paginationLoader: PaginationLoader(
        pageVisibilityListener: (context) =>
            context.select<PostFeedsController, bool>(
                (value) => value.isNextPageLoading),
      ),
    );
  }
}
