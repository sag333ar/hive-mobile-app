import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/feed_grid_view/feed_item_for_grid_view.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = getCrossAxisCount(screenWidth);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverGrid.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              PostFeedModel item = items[index];
              return FeedItemForGridView(
                feedType: feedType,
                item: item,
              );
            },
          ),
          SliverToBoxAdapter(
            child: pageLoader,
          ),
        ],
      ),
    );
  }

  int getCrossAxisCount(double width) {
    if (width > 1300) {
      return 4;
    } else if (width > 974 && width < 1300) {
      return 3;
    } else if (width > 650 && width < 974) {
      return 2;
    } else {
      return 2;
    }
  }
}
