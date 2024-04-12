import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/controller/user_follow_info_list_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/view/user_follow_info_list_widget.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) =>
          UserFollowInfoListController(type: type, accountName: accountName),
      builder: (context, child) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  type == FollowType.followers
                      ? "Followers ($count)"
                      : "Following ($count)",
                  style: theme.textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
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
      },
    );
  }
}
