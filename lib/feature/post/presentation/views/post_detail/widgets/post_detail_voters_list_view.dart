import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/parser.dart';
import 'package:hive_mobile_app/feature/post/models/post_detail/post_detail_model.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailVotersListview extends StatelessWidget {
  const PostDetailVotersListview({super.key, required this.votes});

  final List<ActiveVoteModel> votes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList.builder(
        itemCount: votes.length,
        itemBuilder: (context, index) {
          ActiveVoteModel item = votes[index];
          String timeAgo = timeago.format(item.time ?? DateTime.now());
          return CustomListTile(
            padding: EdgeInsets.zero,
            leading: UserProfileimage(url: item.voter),
            titleText: item.voter,
            subTitle: Text(
              timeAgo,
              style: theme.textTheme.labelMedium!.copyWith(
                  fontSize: 10, color: theme.primaryColorDark.withOpacity(0.7)),
            ),
            titleTrailing: item.reputation != null
                ? TextBox(
                    showBorder: true,
                    textStyle: theme.textTheme.labelSmall,
                    text: Parser.parseAuthorReputation(item.reputation!)
                        .toString(),
                  )
                : null,
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor:
                      theme.colorScheme.secondaryContainer.withOpacity(0.4),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.secondaryContainer),
                  value: (item.percent / 10000),
                ),
                Text(
                  '${item.percent / 100}%',
                  style: theme.textTheme.labelSmall!.copyWith(fontSize: 8),
                )
              ],
            ),
          );
        });
  }
}
