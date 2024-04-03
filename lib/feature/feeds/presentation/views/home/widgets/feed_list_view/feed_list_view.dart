import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/feed_list_view/feed_item_for_list_view.dart';

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
      key: PageStorageKey('$feedType'),
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
