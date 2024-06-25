import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton(
      {super.key,
      required this.text,
      this.icon,
      required this.onPressed,
      this.backgroundColor});

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _button(theme);
  }

  SizedBox _button(ThemeData theme) {
    return SizedBox(
    height: 30,
    child: FilledButton(
        style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: backgroundColor ?? theme.primaryColor),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  icon,
                  size: 18,
                ),
              ),
            AutoSizeText(
              text,
              minFontSize: 12,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
          ],
        )),
  );
  }
}
