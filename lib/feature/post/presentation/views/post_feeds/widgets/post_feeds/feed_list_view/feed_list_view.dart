import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/controller/post_feeds_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_list_view/feed_item_for_list_view.dart';
import 'package:provider/provider.dart';

class FeedListView extends StatelessWidget {
  const FeedListView({super.key, required this.items, this.isSliver = false});

  final List<PostFeedModel> items;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    return isSliver
        ? SliverList.builder(itemCount: items.length, itemBuilder: itemBuilder)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: kScreenVerticalPaddingDigit),
            itemCount: items.length,
            itemBuilder: itemBuilder);
  }

  Widget? itemBuilder(BuildContext context, int index) {
    PostFeedModel item = items[index];
    return Column(
      children: [
        PostItemForListView(item: item),
        if (index == items.length - 1 && !isSliver)
          PaginationLoader(
            pageVisibilityListener: (context) =>
                context.select<PostFeedsController, bool>(
                    (value) => value.isNextPageLoading),
          )
      ],
    );
  }
}
