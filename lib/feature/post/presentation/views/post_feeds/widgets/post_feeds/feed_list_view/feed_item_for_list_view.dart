import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
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
        padding: const EdgeInsets.only(left: 7, right: 7, bottom: 15, top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTile(item: item),
            GestureDetector(
              onTap: () {
                context.platformPushNamed(Routes.postDetailView,
                    pathParameters: {
                      RouteKeys.accountName: item.author,
                      RouteKeys.permlink: item.permlink
                    });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
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
