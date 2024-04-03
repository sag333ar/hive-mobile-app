import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {super.key,
      required this.icon,
      this.iconColor,
      this.iconGap,
      this.textStyle,
      required this.text});
  final IconData icon;
  final Color? iconColor;
  final double? iconGap;
  final TextStyle? textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? theme.primaryColorDark.withOpacity(0.9),
        ),
        SizedBox(width: iconGap ?? 5),
        Text(
          text,
          style: textStyle ??
              theme.textTheme.labelLarge!.copyWith(
                  color: iconColor ?? theme.primaryColorDark.withOpacity(0.9)),
        ),
      ],
    );
  }
}
