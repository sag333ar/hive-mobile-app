import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox(
      {super.key,
      required this.backgroundColor,
      required this.text,
      this.showBorder = false,
      this.icon, this.textColor});

  final Color backgroundColor;
  final String text;
  final bool showBorder;
  final IconData? icon;
  final Color? textColor;

  static const EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 5, vertical: 2);
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: TextBox.padding,
      decoration: BoxDecoration(
          border: showBorder
              ? Border.all(color: theme.primaryColorDark.withOpacity(0.3))
              : null,
          color: backgroundColor,
          borderRadius: TextBox.borderRadius),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                icon,
                size: 12,
              ),
            ),
          Text(
            text,
            style: theme.textTheme.bodySmall!.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
