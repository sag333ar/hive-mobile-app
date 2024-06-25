import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';

class UserFollowInfoListItem extends StatelessWidget {
  const UserFollowInfoListItem(
      {super.key, required this.item, required this.type});

  final FollowInfoModel item;
  final FollowType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String name =
        type == FollowType.followers ? item.follower : item.following;
    return CustomListTile(
      leading: UserProfileimage(
        url: name,
      ),
      borderRadius: context.isMobileSize
          ? null
          : const BorderRadius.all(Radius.circular(8)),
      titleText: name,
      color: theme.colorScheme.tertiaryContainer,
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        context.pop();
        context.platformPushNamed(Routes.userView,
            pathParameters: {RouteKeys.accountName: name});
      },
    );
  }
}
