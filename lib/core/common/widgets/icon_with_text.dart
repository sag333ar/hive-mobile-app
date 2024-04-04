import 'package:auto_size_text/auto_size_text.dart';
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: iconColor ?? theme.primaryColorDark.withOpacity(0.9),
              ),
              SizedBox(width: iconGap ?? 5),
              AutoSizeText(
                text,
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    theme.textTheme.labelLarge!.copyWith(
                        color: iconColor ??
                            theme.primaryColorDark.withOpacity(0.9)),
              ),
            ],
          ),
        ),
        Positioned.fill(
            left: -6,
            right: -6,
            top: -6,
            bottom: -6,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap: () {
                print('tap');
              },
              child: const SizedBox(),
            ))
      ],
    );
  }
}
