import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';

class CommunityItem extends StatelessWidget {
  const CommunityItem({super.key, required this.item});

  final CommunityModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomListTile(
        leading: UserProfileimage(
          url: item.name,
        ),
        titleText: item.title,
        color: theme.primaryColorLight,
        trailing: const Icon(Icons.navigate_next),
        onTap: () => context.platformPushNamed(Routes.communityView,
            pathParameters: {RouteKeys.communityId: item.name}));
  }
}
