import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/feed_list_view/feed_item_for_list_view.dart';

class FeedListView extends StatelessWidget {
  const FeedListView({
    super.key,
    required this.items,
    required this.feedType,
  });

  final List<PostFeedModel> items;
  final FeedType feedType;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      padding:
          const EdgeInsets.symmetric(vertical: kScreenVerticalPaddingDigit),
      itemCount: items.length,
      itemBuilder: (context, index) {
        PostFeedModel item = items[index];
        return PostItemForListView(item: item);
      },
    );
  }
}
