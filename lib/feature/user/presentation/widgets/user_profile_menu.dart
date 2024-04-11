import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_author_reputation.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_info/user_profile_follow_info.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_manabar.dart';
import 'package:intl/intl.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({super.key, required this.item});

  final UserModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String createdAt = DateFormat('d MMMM, yyyy').format(item.created);
    return Padding(
      padding: kScreenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  UserProfileimage(
                    fit: BoxFit.contain,
                    url: item.name,
                    radius: 100,
                  ),
                  const Positioned(
                    bottom: 10,
                    right: 0,
                    child: UserProfileAuthorReputation())
                ],
              ),
            ],
          ),
          const Gap(12),
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          if (item.postingJsonMetadata?.profile?.about != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AutoSizeText(
                item.postingJsonMetadata!.profile!.about!,
                textAlign: TextAlign.center,
                maxLines: 3,
                minFontSize: 10,
                style: theme.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: theme.primaryColorDark.withOpacity(0.9),
                ),
              ),
            ),
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
        ],
      ),
    );
  }
}
