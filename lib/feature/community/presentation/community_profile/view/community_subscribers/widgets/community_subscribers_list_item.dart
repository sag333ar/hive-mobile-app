import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';

class CommunitySubscribersListItem extends StatelessWidget {
  const CommunitySubscribersListItem({
    super.key,
    required this.item,
    this.color,
    required this.popOnTap,
  });

  final CommunityMemberModel item;
  final Color? color;
  final bool? popOnTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool popOnTap = this.popOnTap ?? true;
    return CustomListTile(
      leading: UserProfileimage(
        url: item.name,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      titleText: item.name,
      color: color ?? theme.colorScheme.tertiaryContainer,
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        if (popOnTap) context.pop();
        context.platformPushNamed(Routes.userView,
            pathParameters: {RouteKeys.accountName: item.name});
      },
    );
  }
}
