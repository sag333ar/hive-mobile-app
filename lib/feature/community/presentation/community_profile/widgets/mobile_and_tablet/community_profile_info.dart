import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_vertical_divider.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_detail_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/community_profile_join_add_post_buttons.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/mobile_and_tablet/community_profile_mobile_tablet_info_scroll.dart';

class CommunityProfileInfo extends StatelessWidget {
  const CommunityProfileInfo({super.key, required this.data});

  final CommunityDetailModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverMainAxisGroup(slivers: [
      if (!context.isDesktopSize)
        SliverPadding(
          padding: EdgeInsets.only(top: context.isMobile ? 0 : 10, bottom: 10),
          sliver: SliverAppBar(
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
            floating: context.isMobile,
            backgroundColor: theme.colorScheme.tertiaryContainer,
            actions: [
              if (!context.isMobile)
                const Padding(
                  padding:
                      EdgeInsets.only(right: kScreenHorizontalPaddingDigit),
                  child: CommunityProfileJoinAddPostButtons(),
                ),
            ],
            title: UserImageName(
              name: data.name,
              displayName: data.title,
              textStyle: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      if (!context.isDesktopSize && data.about.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenHorizontalPaddingDigit),
            child: Text(
              data.about,
              style: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: theme.primaryColorDark.withOpacity(0.8)),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
                  horizontal: kScreenHorizontalPaddingDigit)
              .copyWith(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _communityInfo(theme, "Rewards", "\$ ${data.sumPending}"),
              _verticalDivider(theme),
              _communityInfo(theme, "Posters", data.numAuthors.toString()),
              _verticalDivider(theme),
              _communityInfo(
                theme,
                "Language",
                data.lang,
              ),
            ],
          ),
        ),
      ),
      if (!context.isDesktopSize)
        SliverToBoxAdapter(
            child: Padding(
          padding: kScreenHorizontalPadding.copyWith(bottom: 20, top: 0),
        )),
      if (!context.isDesktopSize)
        SliverToBoxAdapter(
          child: CommunityProfileMobileTabletInfoScroll(data: data),
        ),
    ]);
  }

  Column _communityInfo(
    ThemeData theme,
    String title,
    final content,
  ) {
    return Column(
      children: [
        Text(
          content,
          style: theme.textTheme.displayLarge,
        ),
        const Gap(5),
        Text(
          title,
          style: theme.textTheme.bodySmall!
              .copyWith(color: theme.primaryColorDark.withOpacity(0.8)),
        )
      ],
    );
  }

  CustomVerticalDivider _verticalDivider(ThemeData theme) {
    return CustomVerticalDivider(
      height: 50,
      horizontalMargin: 20,
      color: theme.colorScheme.tertiary,
    );
  }
}
