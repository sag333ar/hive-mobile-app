import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile({
    super.key,
    this.backgroundColor,
     this.isInitiallyExpanded = false,
    required this.icon,
    required this.title,
    required this.children,
  });

  final Color? backgroundColor;
  final bool isInitiallyExpanded;
  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0).copyWith(),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: backgroundColor,
          initiallyExpanded: isInitiallyExpanded,
          dense: true,
          childrenPadding: kScreenPadding,
          collapsedBackgroundColor: backgroundColor,
          tilePadding: const EdgeInsets.only(
              top: 0, left: kScreenHorizontalPaddingDigit, right: 8),
          title: Row(
            children: [
              Icon(icon),
              const Gap(10),
              Text(
                title,
                style: theme.textTheme.bodyMedium,
              )
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}
