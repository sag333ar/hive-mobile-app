import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';

class ProfileSliverAppbar extends StatelessWidget {
  const ProfileSliverAppbar({
    super.key, required this.tabBar, required this.actionButtons,
  });

  final Widget tabBar;
  final Widget actionButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      toolbarHeight: 0,
      pinned: context.isDesktopSize,
      floating: !context.isDesktopSize,
      backgroundColor: theme.colorScheme.tertiaryContainer,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tabBar
              ),
            ),
            if (context.isDesktopSize)
               Positioned(
                top: 0,
                right: kScreenHorizontalPaddingDigit,
                child: actionButtons
              )
          ],
        ),
      ),
    );
  }
}
