import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_dialog_template.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/view/user_follow_info_list_widget.dart';

class UserProfileFollowInfoListDialog extends StatelessWidget {
  const UserProfileFollowInfoListDialog(
      {super.key,
      required this.count,
      required this.accountName,
      required this.type});

  final int count;
  final String accountName;
  final FollowType type;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DialogTemplate(
      title: type == FollowType.followers
          ? "Followers ($count)"
          : "Following ($count)",
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: SizedBox(
          height: screenHeight - 100,
          width: 750,
          child: UserFollowInfoListWidget(
            accountName: accountName,
            type: type,
            removeScaffold: true,
            count: count,
            screenWidth: 750,
          ),
        ),
      ),
    );
  }
}
