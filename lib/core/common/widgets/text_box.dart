import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';

class TextBox extends StatelessWidget {
  const TextBox(
      {super.key,
      required this.backgroundColor,
      required this.text,
      this.showBorder = false,
      this.icon,
      this.textColor,
      this.mainAxisAlignment,
      this.borderRadius,
      this.padding, this.onTap});

  final Color backgroundColor;
  final String text;
  final bool showBorder;
  final IconData? icon;
  final Color? textColor;
  final MainAxisAlignment? mainAxisAlignment;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.all(Radius.circular(this.borderRadius ?? 4));
    return InkWellWrapper(
      borderRadius:borderRadius ,
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
            border: showBorder
                ? Border.all(color: theme.primaryColorDark.withOpacity(0.3))
                : null,
            color: backgroundColor,
            borderRadius:borderRadius),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
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
      ),
    );
  }
}
