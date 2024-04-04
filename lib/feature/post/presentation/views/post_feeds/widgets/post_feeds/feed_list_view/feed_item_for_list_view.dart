import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/interaction_tile.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/post_image.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/user_tile.dart';

class PostItemForListView extends StatelessWidget {
  const PostItemForListView({super.key, required this.item});

  final PostFeedModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTile(item: item),
            PostImage(
              item: item,
              height: 190,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            AutoSizeText(
              item.title,
              maxLines: 3,
              minFontSize: 13,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(),
            ),
            InteractionTile(item: item)
          ],
        ),
      ),
    );
  }
}
