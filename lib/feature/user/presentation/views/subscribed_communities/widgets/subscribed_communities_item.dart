import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_team_widget.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';

class SubscribedCommunitiesItem extends StatelessWidget {
  const SubscribedCommunitiesItem({
    super.key,
    required this.item,
  });

  final SubscribedCommunityModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final roleColor =
        CommunityTeamWidget.getCommunityRoleColor(item.role, theme);
    return CustomListTile(
      borderRadius:
          BorderRadius.all(Radius.circular(context.isMobileSize ? 0 : 40)),
      leading: UserProfileimage(
        url: item.id,
      ),
      titleText: item.name,
      color: theme.colorScheme.onTertiaryContainer,
      trailing: TextBox(
        text: item.role,
        showBorder: true,
        borderRadius: 40,
        borderColor: roleColor,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        textStyle: theme.textTheme.labelLarge!.copyWith(
          color: roleColor,
        ),
      ),
      onTap: () {
        context.platformPushNamed(Routes.communityView,
            pathParameters: {RouteKeys.communityId: item.id});
      },
    );
  }
}
