import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/view/community_subscribers_list_widget.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_subscriber_list_dialog.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/mobile_and_tablet/community_content_dialog.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/profile_mobile_tablet_info_scroll_template.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/profile_mobile_tablet_info_scroll_tile.dart';

class CommunityProfileMobileTabletInfoScroll extends StatelessWidget {
  const CommunityProfileMobileTabletInfoScroll({
    super.key,
    required this.data,
  });

  final CommunityDetailModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProfileMobileTabletInfoScrollTemplate(
      children: [
        ProfileMobileTabletInfoScrollTile(
          leftPadding: 0,
          onTap: () => onSubscribersTap(context),
          color: theme.primaryColor,
          text: 'Subscribers - ${data.subscribers}',
        ),
        if (data.description != null && data.description!.isNotEmpty)
          ProfileMobileTabletInfoScrollTile(
            icon: Icons.description,
            text: "Description",
            onTap: () => openDialog(
              context,
              title: "Description",
              content: data.description!,
            ),
          ),
        if (data.flagText != null && data.flagText!.isNotEmpty)
          ProfileMobileTabletInfoScrollTile(
              onTap: () => openDialog(
                    context,
                    title: "Rules",
                    content: data.flagText!,
                  ),
              icon: Icons.rule,
              text: "Rules"),
        if (data.team != null && data.team!.isNotEmpty)
          ProfileMobileTabletInfoScrollTile(
            icon: Icons.people,
            text: "Team",
            onTap: () => openDialog(
              context,
              title: "Team",
              team: data.team!,
            ),
          ),
      ],
    );
  }

  void openDialog(BuildContext context,
      {String? content,
      required String title,
      List<CommunityMemberModel>? team}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CommunityContentDialog(
          title: title,
          content: content,
          team: team,
        );
      },
    );
  }

  void onSubscribersTap(BuildContext context) {
    if (context.isMobile) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CommunitySubscribersListWidget(
              communityId: data.name,
              removeScaffold: false,
              count: data.subscribers),
        ),
      );
    } else {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CommunitySubscribersListDialog(
            communityId: data.name,
            count: data.subscribers,
          );
        },
      );
    }
  }
}
