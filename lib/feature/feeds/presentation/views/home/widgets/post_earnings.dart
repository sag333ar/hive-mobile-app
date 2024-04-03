import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';

class PostEarnings extends StatelessWidget {
  const PostEarnings(
      {super.key,
      required this.pendingPayoutvalue,
      this.iconColor,
      this.iconGap,
      this.textStyle});

  final String? pendingPayoutvalue;
  final Color? iconColor;
  final double? iconGap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    var value =
        double.parse(pendingPayoutvalue?.replaceAll(" HBD", "") ?? "0.0");
    return IconWithText(
      icon: Icons.arrow_circle_up_outlined,
      iconColor: iconColor,
      text: "\$ ${value.toStringAsFixed(2)}",
      textStyle: textStyle,
      iconGap: iconGap,
    );
  }
}
