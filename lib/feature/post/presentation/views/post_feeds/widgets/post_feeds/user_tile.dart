import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

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
        InkWellWrapper(
          onTap: () => pushToUserView(context),
          child: UserProfileimage(
            url: item.author,
            radius: userImageRadius,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        isGridView
            ? Expanded(
                child: InkWellWrapper(
                onTap: () => pushToUserView(context),
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
                ),
              ))
            : RichText(
                text: TextSpan(
                  text: item.author,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => pushToUserView(context),
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

  void pushToUserView(BuildContext context) {
    context.platformPushNamed(Routes.userView,
        pathParameters: {RouteKeys.accountName: item.author});
  }

  TextStyle textStyle(ThemeData theme) {
    return theme.textTheme.bodySmall!.copyWith(
      overflow: TextOverflow.ellipsis,
    );
  }
}
