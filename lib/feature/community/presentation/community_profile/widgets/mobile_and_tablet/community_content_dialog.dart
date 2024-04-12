import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_team_widget.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/profile_linkify_text.dart';

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
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: theme.primaryColorLight,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.cancel))
        ],
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400, maxHeight: screenHeight),
        child: SizedBox(
          width: team != null ? 30 : null,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: team != null
                ? CommunityTeamWidget(
                    team: team!,
                    fromDialog: true,
                  )
                : ProfileLinkifyText(
                    content: content!,
                  ),
          ),
        ),
      ),
    );
  }
}
