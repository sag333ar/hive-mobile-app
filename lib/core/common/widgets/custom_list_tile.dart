import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.leading,
      required this.titleText,
      this.trailing,
      this.onTap,
      this.color, this.padding});

  final Widget leading;
  final String titleText;
  final Widget? trailing;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: onTap,
      child: Container(
        color: color,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading,
            const Gap(12.5),
            Expanded(
              child: Text(
                titleText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const Gap(20),
            trailing ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
