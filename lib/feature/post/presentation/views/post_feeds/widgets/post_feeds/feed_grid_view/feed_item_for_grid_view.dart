import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/blur_widget.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/view/post_detail_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/comment_icon_button.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/post_earnings.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/post_image.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/user_tile.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_feeds/widgets/post_feeds/vote_icon_button.dart';
import 'package:reading_time/reading_time.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedItemForGridView extends StatefulWidget {
  const FeedItemForGridView({super.key, required this.item});

  final PostFeedModel item;

  @override
  State<FeedItemForGridView> createState() => _FeedItemForGridViewState();
}

class _FeedItemForGridViewState extends State<FeedItemForGridView> {
  late bool isUserVoted;
  late int numberOfVotes;
  late ThemeData theme;

  @override
  void initState() {
    _initVoteData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FeedItemForGridView oldWidget) {
    _initVoteData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  void _initVoteData() {
    // isUserVoted = FeedUtil.isVotedByUser(
    //     widget.appData.userData, widget.item.activeVotes ?? []);
    numberOfVotes = (widget.item.activeVotes ?? []).length;
  }

  @override
  Widget build(BuildContext context) {
    var timeAgo = timeago.format(
        DateTime.tryParse('${widget.item.created}+00:00') ?? DateTime.now());
    String readTime = readingTime(widget.item.body).msg;
    readTime = readTime == "less than a minute" ? "1 min read" : readTime;
    return Card(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.platformPushNamed(Routes.postDetailView, pathParameters: {
              RouteKeys.accountName: widget.item.author,
              RouteKeys.permlink: widget.item.permlink
            });
          },
          child: Stack(
            children: [
              PostImage(
                isGridView: true,
                item: widget.item,
                height: double.infinity,
                width: double.infinity,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Blurwidget(
                  beginAlignment: Alignment.topCenter,
                  endAlignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kScreenHorizontalPaddingDigit),
                    child: UserTile(
                      item: widget.item,
                      isGridView: true,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Blurwidget(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: kScreenHorizontalPaddingDigit),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.item.title,
                            maxLines: 1,
                            minFontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                timeAgo,
                                style: theme.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: theme.primaryColorDark
                                        .withOpacity(0.7)),
                              ),
                              Text(
                                readTime,
                                style: theme.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: theme.primaryColorDark
                                        .withOpacity(0.7)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.basic,
                            child: Row(
                              children: [
                                PostEarnings(
                                    pendingPayoutvalue:
                                        widget.item.pendingPayoutValue),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Spacer(),
                                VoteIconButton(item: widget.item),
                                const SizedBox(width: 15),
                                CommentIconButton(item: widget.item),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
