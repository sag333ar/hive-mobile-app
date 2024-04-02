import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class InteractionTile extends StatelessWidget {
  const InteractionTile({super.key, required this.item});

  final PostFeedModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _extraRow(theme);
  }

  Widget _extraRow(ThemeData theme) {
    final iconColor = theme.primaryColorDark.withOpacity(0.7);
    const iconGap = 5.0;
    var timeAgo = timeago.format(item.created ?? DateTime.now());
    var value =
        double.parse(item.pendingPayoutValue?.replaceAll(" HBD", "") ?? "0.0");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_up_outlined,
                color: iconColor,
              ),
              const SizedBox(width: iconGap),
              Text(
                "\$ ${value.toStringAsFixed(2)}",
                style: style(theme),
              ),
            ],
          ),
          verticalDivider(theme),
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: iconColor,
              ),
              const SizedBox(width: iconGap),
              Text(
                "${item.activeVotes?.length ?? 0}",
                style: style(theme),
              ),
            ],
          ),
          verticalDivider(theme),
          Row(
            children: [
              Icon(
                Icons.comment,
                color: iconColor,
              ),
              const SizedBox(width: iconGap),
              Text(
                "${item.children ?? 0}",
                style: style(theme),
              ),
            ],
          ),
          verticalDivider(theme),
          Row(
            children: [
              Icon(
                Icons.lock_clock,
                color: iconColor,
              ),
              const SizedBox(width: iconGap),
              AutoSizeText(
                timeAgo,
                maxLines: 1,
                minFontSize: 11,
                overflow: TextOverflow.ellipsis,
                style: style(theme),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container verticalDivider(ThemeData theme) {
    return Container(height: 25, width: 1, color: theme.dividerColor);
  }

  TextStyle style(ThemeData theme) {
    return theme.textTheme.bodySmall!;
  }
}
