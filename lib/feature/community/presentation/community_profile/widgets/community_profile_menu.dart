import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/expandable_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_subscriber_list_dialog.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_team_widget.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/profile_linkify_text.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';

class CommunityProfileMenu extends StatelessWidget {
  const CommunityProfileMenu({super.key, required this.item});

  final CommunityDetailModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.onTertiaryContainer;
    const borderRadius = BorderRadius.all(Radius.circular(8));
    return ProfileMenuTemplate(
      urlName: item.name,
      displayName: item.title,
      description: item.about,
      children: [
        const Gap(15),
        OutlinedButton(
            onPressed: () => openDialog(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.primaryColor),
            ),
            child: Text(
              'Subscribers - ${item.subscribers}',
              style: theme.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w400),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              IconWithText(
                  expand: true,
                  iconGap: 10,
                  borderRadius: borderRadius,
                  color: backgroundColor.withOpacity(0.1),
                  icon: Icons.attach_money,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  text: "Rewards - ${item.sumPending}"),
              const Gap(10),
              IconWithText(
                  expand: true,
                  iconGap: 10,
                  icon: Icons.dashboard,
                  borderRadius: borderRadius,
                  color: backgroundColor.withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  text: "Posters - ${item.numAuthors}"),
              const Gap(10),
              IconWithText(
                  expand: true,
                  iconGap: 10,
                  icon: Icons.language,
                  borderRadius: borderRadius,
                  color: backgroundColor.withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  text: "Language - ${item.lang}"),
            ],
          ),
        ),
        const Gap(10),
        if (item.description != null)
          ExpandableTile(
            icon: Icons.info,
            backgroundColor: backgroundColor,
            title: "Description",
            children: [
              ProfileLinkifyText(content: item.description!),
            ],
          ),
        if (item.flagText != null)
          ExpandableTile(
            icon: Icons.rule,
            backgroundColor: backgroundColor,
            title: "Rules",
            children: [
              ProfileLinkifyText(content: item.flagText!),
            ],
          ),
        if (item.team != null && item.team!.isNotEmpty)
          ExpandableTile(
            icon: Icons.people,
            isInitiallyExpanded: true,
            backgroundColor: backgroundColor,
            title: "Team",
            children: [
              CommunityTeamWidget(
                team: item.team!,
                removePadding: true,
              ),
            ],
          ),
      ],
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CommunitySubscribersListDialog(
          communityId: item.name,
          count: item.subscribers,
        );
      },
    );
  }
}
