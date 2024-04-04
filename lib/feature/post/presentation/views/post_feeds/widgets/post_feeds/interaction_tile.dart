import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/icon_with_text.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/post_earnings.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/vote_icon_button.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostEarnings(
            pendingPayoutvalue: item.pendingPayoutValue,
            iconColor: iconColor,
            iconGap: iconGap,
            textStyle: style(theme),
          ),
          verticalDivider(theme),
          VoteIconButton(
            item: item,
            iconColor: iconColor,
            iconGap: iconGap,
            textStyle: style(theme),
          ),
          verticalDivider(theme),
          IconWithText(
            icon:  Icons.comment, 
            iconColor: iconColor,
            text:  "${item.children ?? 0}",
            iconGap: iconGap,
            textStyle: style(theme),
            ),
          verticalDivider(theme),
            IconWithText(
            icon:  Icons.lock_clock, 
            iconColor: iconColor,
            text: timeAgo,
            iconGap: iconGap,
            textStyle: style(theme),
            ),
        ],
      ),
    );
  }

  Container verticalDivider(ThemeData theme) {
    return Container(height: 25, width: 1, color: theme.dividerColor);
  }

  TextStyle style(ThemeData theme) {
    return theme.textTheme.labelLarge!;
  }
}
