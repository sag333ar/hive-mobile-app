import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_author_reputation.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_badges/widgets/user_profile_badges.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_info/user_profile_follow_info.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_manabar.dart';
import 'package:intl/intl.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({super.key, required this.item});

  final UserModel item;

  @override
  Widget build(BuildContext context) {
    String createdAt = DateFormat('d MMMM, yyyy').format(item.created);
    return ProfileMenuTemplate(
        urlName: item.name,
        displayName: item.name,
        profileImageFooter: const UserProfileAuthorReputation(),
        description: item.postingJsonMetadata?.profile?.about,
        children: [
          if (item.votingManabar != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: UserProfileManaBar(
                  icon: Icons.thumb_up,
                  manabarColor: Colors.greenAccent.withOpacity(0.85),
                  mana: item.votingManabar!.currentMana ?? 0,
                  toolTip: 'Upvote Mana'),
            ),
          if (item.downvoteManabar != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: UserProfileManaBar(
                  icon: Icons.thumb_down,
                  manabarColor: Colors.red,
                  mana: item.downvoteManabar!.currentMana ?? 0,
                  toolTip: 'DownVote Mana'),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(),
          ),
          FollowInfo(
            direction: Axis.vertical,
            accountName: item.name,
          ),
          if (item.location != null && item.location!.isNotEmpty)
            IconWithText(
                expand: true,
                iconGap: 10,
                icon: Icons.location_on,
                text: item.location!),
          if (item.website != null && item.website!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: IconWithText(
                  maxlines: 2,
                  expand: true,
                  onTap: () {
                    Act.launchThisUrl(item.website!);
                  },
                  iconGap: 10,
                  icon: Icons.public,
                  text: item.website!),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: IconWithText(
                expand: true, iconGap: 10, icon: Icons.event, text: createdAt),
          ),
          const UserProfileBadges()
        ]);
  }
}
