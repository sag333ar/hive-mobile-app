import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_tab_bar.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/common/widgets/info_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/feature/post/models/post_detail/post_detail_model.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/controller/post_detail_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/widgets/comments/comments_widget_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/widgets/post_detail_voters_list_view.dart';
import 'package:provider/provider.dart';
import 'package:reading_time/reading_time.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailWebInfoWidget extends StatefulWidget {
  const PostDetailWebInfoWidget({super.key, required this.data});

  final PostDetailModel data;

  @override
  State<PostDetailWebInfoWidget> createState() =>
      _PostDetailWebInfoWidgetState();
}

class _PostDetailWebInfoWidgetState extends State<PostDetailWebInfoWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String timeAgo = timeago.format(widget.data.created ?? DateTime.now());
    String readTime = readingTime(widget.data.body).msg;
    String words = readingTime(widget.data.body).words.toString();
    readTime = readTime == "less than a minute" ? "1 min read" : readTime;
    return Container(
      // color: Theme.of(context).colorScheme.tertiaryContainer,
      padding:
          const EdgeInsets.symmetric(vertical: kScreenVerticalPaddingDigit),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: kScreenHorizontalPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.title!,
                    style: theme.textTheme.displayLarge!.copyWith(fontSize: 24),
                  ),
                  const Gap(10),
                  _userInfoAndTimeData(theme, timeAgo, readTime, words),
                  const Gap(10),
                  if (widget.data.jsonMetadata != null &&
                      widget.data.jsonMetadata!.tags != null &&
                      widget.data.jsonMetadata!.tags!.isNotEmpty)
                    _tags(theme),
                  const Gap(20),
                  const Divider(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: kScreenHorizontalPadding,
            sliver: SliverAppBar(
              toolbarHeight: 0,
              pinned: true,
              floating: true,
              bottom: ColoredTabBar(
                color: theme.colorScheme.tertiaryContainer,
                tabBar: _tabBar(theme),
              ),
            ),
          ),
          SliverPadding(
            padding: kScreenHorizontalPadding,
            sliver: _body(theme),
          )
        ],
      ),
    );
  }

  Widget _body(ThemeData theme) {
    final controller = context.read<PostDetailController>();
    switch (currentIndex) {
      case 0:
        return _voters(theme);
      case 1:
        return CommentsWidgetView(
            author: controller.accountName, permlink: controller.permlink);
      default:
        return _voters(theme);
    }
  }

  Widget _voters(ThemeData theme) {
    List<ActiveVoteModel>? items = widget.data.activeVotes;
    if (items != null && items.isNotEmpty) {
      return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          sliver: PostDetailVotersListview(votes: items));
    } else {
      return const Emptystate(
        text: "No Voters found",
        isSliver: true,
      );
    }
  }

  TabBar _tabBar(ThemeData theme, {Color? dividerColor}) {
    return TabBar(
      controller: _tabController,
      padding: EdgeInsets.zero,
      isScrollable: true,
      labelPadding: const EdgeInsets.only(right: 20),
      unselectedLabelColor: theme.primaryColorDark.withOpacity(0.8),
      tabAlignment: TabAlignment.start,
      indicatorColor: theme.primaryColor,
      dividerColor: dividerColor ?? theme.colorScheme.tertiaryContainer,
      onTap: (value) {
        if (mounted) {
          setState(() {
            currentIndex = value;
          });
        }
      },
      tabs: const [
        Tab(text: "Voters"),
        Tab(text: "Comments"),
      ],
    );
  }

  Row _userInfoAndTimeData(
      ThemeData theme, String timeAgo, String readTime, String words) {
    return Row(
      children: [
        UserProfileimage(
          url: widget.data.author,
          radius: 60,
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.author,
                style: theme.textTheme.displaySmall,
              ),
              Text(
                timeAgo,
                style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.primaryColorDark.withOpacity(0.7),
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        const Gap(15),
        IntrinsicWidth(
          child: Column(
            children: [
              TextBox(
                text: readTime,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                backgroundColor: theme.colorScheme.tertiary,
                textStyle: theme.textTheme.labelMedium,
              ),
              const Gap(5),
              TextBox(
                text: "$words words",
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                backgroundColor: theme.colorScheme.tertiary,
                textStyle: theme.textTheme.labelMedium,
              )
            ],
          ),
        )
      ],
    );
  }

  Wrap _tags(ThemeData theme) {
    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: List.generate(
          widget.data.jsonMetadata!.tags!.length,
          (index) => InfoTile(
              color: theme.colorScheme.onTertiaryContainer,
              textStyle: theme.textTheme.bodySmall,
              text: "# ${widget.data.jsonMetadata!.tags![index]}")),
    );
  }
}
