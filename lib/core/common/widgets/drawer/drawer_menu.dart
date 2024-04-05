import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/drawer_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/expandable_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';
import 'package:hive_mobile_app/core/common/widgets/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
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
              thickness: 0.5, color: theme.primaryColorDark.withOpacity(0.4))),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: const [0.45, 1],
                colors: [theme.primaryColorLight, theme.colorScheme.tertiary])),
        padding: const EdgeInsets.only(top: 30, bottom: 20),
        child: SafeArea(
          child: Column(
            children: [
              InkWellWrapper(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kScreenHorizontalPaddingDigit),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                          child: UserProfileimage(
                              radius: 75, url: 'i-am-the-flash')),
                      Center(
                        child: Text(
                          'I-am-the-flash',
                          style: theme.textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const Gap(15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DrawerTile(
                          onTap: () {}, text: 'Profile', icon: Icons.person),
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
                              onTap: () => popAndPushNamed(context,Routes.witnessesView),
                              text: "Witnesses",
                              icon: Icons.group),
                          DrawerTile(
                              leftPadding: 30,
                              onTap: () {},
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
                          onTap: () {}, text: "Settings", icon: Icons.settings),
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
      ),
    );
  }

  void popAndPushNamed(BuildContext context, String name) {
    context.pop();
    context.pushNamed(name);
  }
}
