import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {super.key,
      required this.icon,
      this.iconColor,
      this.iconGap,
      this.textStyle,
      this.onTap,
      this.expand = false,
      required this.text,
      this.maxlines});
  final IconData icon;
  final Color? iconColor;
  final double? iconGap;
  final TextStyle? textStyle;
  final String text;
  final VoidCallback? onTap;
  final bool expand;
  final int? maxlines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor ?? theme.primaryColorDark.withOpacity(0.9),
            ),
            SizedBox(width: iconGap ?? 5),
            expand
                ? Expanded(
                    child: _text(theme),
                  )
                : _text(theme),
          ],
        ),
      ),
    );
  }

  AutoSizeText _text(ThemeData theme) {
    return AutoSizeText(
      text,
      maxLines: maxlines ?? 1,
      minFontSize: 10,
      overflow: TextOverflow.ellipsis,
      style: textStyle ??
          theme.textTheme.labelLarge!.copyWith(
              color: iconColor ?? theme.primaryColorDark.withOpacity(0.9)),
    );
  }
}
