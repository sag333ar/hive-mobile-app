import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/user_profile_image.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key,
      required this.item,
      this.userImageRadius = 35,
       this.isGridView = false});

  final PostFeedModel item;
  final double userImageRadius;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UserProfileimage(
          url: item.author,
          radius: userImageRadius,
        ),
        const SizedBox(
          width: 8,
        ),
        isGridView
            ? Expanded(
                child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  item.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(theme).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
            : RichText(
                text: TextSpan(
                  text: item.author,
                  style: textStyle(theme).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "  # ${item.jsonMetadata?.tags?.firstOrNull ?? "Hive"}",
                      style: textStyle(theme),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        if (isGridView)
          Text(
            "# ${item.jsonMetadata?.tags?.firstOrNull ?? "Hive"}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle(theme),
          ),
      ],
    );
  }

  TextStyle textStyle(ThemeData theme) {
    return theme.textTheme.bodySmall!.copyWith(
      overflow: TextOverflow.ellipsis,
    );
  }
}
