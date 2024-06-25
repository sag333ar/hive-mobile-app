import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';
import 'package:hive_mobile_app/core/utilities/parser.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.item});

  final PostFeedModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isPadded = item.depth != 1;
    var timeInString = timeago.format(item.created);
    double depth = (isPadded ? 50.0 : 0);
    return Container(
      padding: EdgeInsets.only(
          left: depth, right: 15, bottom: 15, top: isPadded ? 0 : 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserProfileimage(url: item.author),
              const Gap(
                8,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      item.author,
                    ),
                    const Gap(
                      12,
                    ),
                    const Icon(
                      Icons.thumb_up_outlined,
                      size: 15,
                    ),
                    const Gap(
                      5,
                    ),
                    Text(
                      item.activeVotes!.length.toString(),
                    ),
                    const Gap(
                      12,
                    ),
                    const Icon(
                      Icons.schedule,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        timeInString,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(
            8,
          ),
          _comment(item.body, theme)
        ],
      ),
    );
  }

  Widget _comment(String text, ThemeData theme) {
    return MarkdownBody(
      styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
        a: _commentTextStyle(theme),
        p: _commentTextStyle(theme),
      ),
      data: Parser.removeAllHtmlTags(text),
      shrinkWrap: true,
      onTapLink: (text, url, title) {
        Act.launchThisUrl(url ?? 'https://google.com');
      },
    );
  }

  TextStyle _commentTextStyle(ThemeData theme) {
    return theme.textTheme.bodyMedium!
        .copyWith(color: theme.primaryColorDark.withOpacity(0.8));
  }
}
