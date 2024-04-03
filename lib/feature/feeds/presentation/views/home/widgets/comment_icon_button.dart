import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';

class CommentIconButton extends StatelessWidget {
  const CommentIconButton(
      {super.key,
      required this.item,
      this.iconColor,
      this.textStyle,
      this.iconGap});

  final PostFeedModel item;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double? iconGap;

  @override
  Widget build(BuildContext context) {
    return IconWithText(
      icon: Icons.comment,
      text: "${item.children ?? 0}",
      iconColor: iconColor,
      iconGap: iconGap,
      textStyle: textStyle,
    );
  }
}
