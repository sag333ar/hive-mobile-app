import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:auth/core/extensions/ui.dart';
import 'package:auth/core/widgets/drawer_header.dart';
import 'package:auth/feature/user/presentation/view/multi_account_dialog_view.dart';
import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/drawer_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/expandable_tile.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/core/utilities/theme/theme_mode.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = context.read<ThemeController>();
    return Theme(
        data: theme.copyWith(
            dividerTheme: DividerThemeData(
                thickness: 0.5,
                color: theme.primaryColorDark.withOpacity(0.4))),
        child: Consumer<UserController>(
          builder: (context, userController, child) {
            final bool isLoggedIn = userController.isUserLoggedIn;
            log(context.read<UserController>().loginToken.toString());
            return Container(
              width: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(stops: const [
                0.45,
                1
              ], colors: [
                theme.primaryColorLight,
                theme.colorScheme.tertiary
              ])),
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: SafeArea(
                child: Column(
                  children: [
                    MyDrawerHeader(
                      onAccountSelect: () => onProfileTap(context),
                      loginTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AuthView()));
                      },
                      profileTap: () => context.popAndPlatformPushNamed(
                          Routes.userView,
                          pathParameters: {
                            RouteKeys.accountName: userController.userName!
                          }),
                    ),
                    const Divider(),
                    const Gap(15),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (isLoggedIn)
                              DrawerTile(
                                  onTap: () => context.popAndPlatformPushNamed(
                                      Routes.inboxView),
                                  text: 'Inbox',
                                  icon: Icons.inbox),
                            DrawerTile(
                                onTap: () {},
                                text: 'Bookmarks',
                                icon: Icons.bookmarks),
                            DrawerTile(
                                onTap: () {},
                                text: 'Communities',
                                icon: Icons.people),
                            ExpandableItem(
                              header: const DrawerTile(
                                  text: 'Governanace',
                                  icon: Icons.leaderboard_rounded),
                              children: [
                                DrawerTile(
                                    leftPadding: 30,
                                    onTap: () =>
                                        context.popAndPlatformPushNamed(
                                            Routes.witnessesView),
                                    text: "Witnesses",
                                    icon: Icons.group),
                                DrawerTile(
                                    leftPadding: 30,
                                    onTap: () =>
                                        context.popAndPlatformPushNamed(
                                            Routes.proposalsView),
                                    text: "Proposals",
                                    icon: Icons.recommend),
                              ],
                            ),
                            DrawerTile(
                                onTap: () {
                                  themeController.toggleTheme();
                                },
                                text: themeController.isLightTheme()
                                    ? "Dark Mode"
                                    : "Light Mode",
                                icon: themeController.isLightTheme()
                                    ? Icons.dark_mode
                                    : Icons.light_mode),
                            DrawerTile(
                                onTap: () {},
                                text: "Settings",
                                icon: Icons.settings),
                            if (isLoggedIn)
                              DrawerTile(
                                  onTap: () => _logOutOnTap(context),
                                  text: "Log out",
                                  icon: Icons.logout),
                            const Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 0),
                              child: Divider(),
                            ),
                            DrawerTile(
                              onTap: () {},
                              text: "App Version",
                              icon: Icons.info,
                              trailing: Text(
                                "0.01",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void onProfileTap(BuildContext context) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => MultiAccountDialog(
        addAccountOnTap: () => context.popAndPlatformPushNamed(Routes.authView),
      ),
    );
  }

  void _logOutOnTap(BuildContext context) {
    context.showLoader();
    context.read<UserController>().logOutUser().then(
      (v) {
        context.hideLoader();
        Navigator.pop(context);
      },
    );
  }
}
