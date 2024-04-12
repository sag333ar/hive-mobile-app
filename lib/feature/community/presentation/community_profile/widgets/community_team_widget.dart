import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';

class CommunityTeamWidget extends StatelessWidget {
  const CommunityTeamWidget(
      {super.key, required this.team, this.fromDialog = false});

  final List<CommunityMemberModel> team;
  final bool fromDialog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: List.generate(team.length, (index) {
          final member = team[index];
          return Row(
            children: [
              UserImageName(
                onTap: () {
                  if (fromDialog) context.pop();
                  context.platformPushNamed(Routes.userView,
                      pathParameters: {RouteKeys.accountName: member.name});
                },
                name: member.name,
                imageRadius: 20,
                textStyle: theme.textTheme.labelLarge,
              ),
              const Gap(10),
              TextBox(
                  showBorder: true,
                  borderRadius: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  backgroundColor: Colors.transparent,
                  borderColor: getCommunityRoleColor(member.role, theme),
                  textStyle: theme.textTheme.labelMedium!.copyWith(
                      color: getCommunityRoleColor(member.role, theme)),
                  text: member.role)
            ],
          );
        }),
      ),
    );
  }

  Color getCommunityRoleColor(String role, ThemeData theme) {
    if (role == 'owner') {
      return Colors.red;
    } else if (role == "admin") {
      return Colors.blue;
    } else {
      return Colors.yellow;
    }
  }
}
