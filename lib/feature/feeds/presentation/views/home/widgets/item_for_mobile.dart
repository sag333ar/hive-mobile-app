import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/interaction_tile.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/post_image.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/widgets/user_tile.dart';

class PostItemForMobile extends StatelessWidget {
  const PostItemForMobile({super.key, required this.item});

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
              height: 8,
            ),
            AutoSizeText(
              item.title,
              maxLines: 3,
              minFontSize: 13,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge!
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
