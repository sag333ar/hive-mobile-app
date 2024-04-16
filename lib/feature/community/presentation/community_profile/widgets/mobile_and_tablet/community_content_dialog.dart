import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_scroll_dialog.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_text_dialog.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_team_widget.dart';

class CommunityContentDialog extends StatelessWidget {
  const CommunityContentDialog(
      {super.key, required this.title, required this.content, this.team})
      : assert(!(content == null && team == null),
            'content or team, anyone is required');

  final String title;
  final String? content;
  final List<CommunityMemberModel>? team;

  @override
  Widget build(BuildContext context) {
    return team != null
        ? ResponsiveScrollDialog(
            title: title,
            content: CommunityTeamWidget(
              team: team!,
              fromDialog: true,
            ),
          )
        : ResponsiveTextDialog(title: title, content: content!);
  }
}
