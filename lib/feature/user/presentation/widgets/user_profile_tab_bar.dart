import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/app_router.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_tab_tile.dart';

class UserProfileTabBar extends StatefulWidget {
  const UserProfileTabBar(
      {super.key, required this.accountName, required this.onChange});

  final String accountName;
  final VoidCallback onChange;

  @override
  State<UserProfileTabBar> createState() => _UserProfileTabBarState();
}

class _UserProfileTabBarState extends State<UserProfileTabBar> {
  @override
  Widget build(BuildContext context) {
    final String currentRoute = AppRouter
        .router.routerDelegate.currentConfiguration.uri.path
        .toString();
    return Padding(
      padding: const EdgeInsets.only(
          left: kScreenHorizontalPaddingDigit,
          right: kScreenHorizontalPaddingDigit,
          bottom: 10),
      child: Row(
        children: [
          UserProfileTabBarTile(
            isSelected:
                isRootview(currentRoute) || currentRoute.contains('blog'),
            text: "Blog",
            onTap: () => _goToRoute(Routes.userBlogView),
          ),
          UserProfileTabBarTile(
            isSelected: currentRoute.contains('posts'),
            text: "Posts",
            onTap: () => _goToRoute(Routes.userPostsView),
          ),
          UserProfileTabBarTile(
            isSelected: currentRoute.contains('comments'),
            text: "Comments",
            onTap: () => _goToRoute(Routes.userCommentsView),
          ),
          UserProfileTabBarTile(
            isSelected: currentRoute.contains('replies'),
            text: "replies",
            onTap: () => _goToRoute(Routes.userRepliesView),
          ),
        ],
      ),
    );
  }

  bool isRootview(String str) {
    int count = str.split('/').length - 1;
    return count == 1;
  }

  void _goToRoute(String route) {
    if (mounted) {
      widget.onChange();
      context
          .goNamed(route, pathParameters: {'accountName': widget.accountName});
      setState(() {});
    }
  }
}
