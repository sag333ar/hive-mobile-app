import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';

class ProfileMobileTabletInfoScrollTemplate extends StatelessWidget {
  const ProfileMobileTabletInfoScrollTemplate({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kScreenHorizontalPaddingDigit,
                ),
                child: SizedBox(
                  height: 35,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:children
                    ),
                  ),
                )),
            if (context.isWeb) const Gap(10),
            if (context.isWeb) const Divider()
          ],
        ),
        if (!context.isWeb)
          const Positioned(bottom: -25, left: 0, right: 0, child: Divider())
      ],
    );
  }
}
