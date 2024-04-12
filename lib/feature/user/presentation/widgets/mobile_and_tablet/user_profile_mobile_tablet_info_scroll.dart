import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/profile_mobile_tablet_info_scroll_template.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/profile_mobile_tablet_info_scroll_tile.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_info/user_profile_follow_info.dart';
import 'package:intl/intl.dart';

class UserProfileMobileTabletInfoTile extends StatelessWidget {
  const UserProfileMobileTabletInfoTile({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return ProfileMobileTabletInfoScrollTemplate(
      children: [
        FollowInfo(
          direction: Axis.horizontal,
          accountName: data.name,
        ),
        if (data.location != null && data.location!.isNotEmpty)
          ProfileMobileTabletInfoScrollTile(
            icon: Icons.location_on,
            text: data.location!,
          ),
        if (data.website != null && data.website!.isNotEmpty)
          ProfileMobileTabletInfoScrollTile(
            onTap: () => Act.launchThisUrl(data.website!),
            icon: Icons.public,
            text: data.website!,
          ),
        ProfileMobileTabletInfoScrollTile(
          icon: Icons.event,
          text: DateFormat('d MMMM, yyyy').format(data.created),
        ),
      ],
    );
  }
}
