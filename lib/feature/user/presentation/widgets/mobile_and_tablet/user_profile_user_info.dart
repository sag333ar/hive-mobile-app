import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_scroll_dialog.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_layout.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_badges/widgets/user_profile_badges.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/mobile_and_tablet/user_profile_mobile_tablet_info_scroll.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_author_reputation.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_mute_buttons.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_manabar.dart';
import 'package:provider/provider.dart';

class UserProfileUserInfo extends StatelessWidget {
  const UserProfileUserInfo({super.key, required this.data});

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<UserProfileController>();
    return SliverMainAxisGroup(slivers: [
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
                padding: EdgeInsets.only(right: kScreenHorizontalPaddingDigit),
                child: Row(
                  children: [
                    UserProfileAuthorReputation(
                      isFilled: false,
                    ),
                    Gap(10),
                    UserProfileFollowMuteButtons()
                  ],
                ),
              ),
            if (context.isMobile)
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: UserProfileAuthorReputation(
                  isFilled: false,
                ),
              ),
          ],
          title: UserImageName(
            name: data.name,
            textStyle: theme.textTheme.bodyMedium,
          ),
        ),
      ),
      if (data.postingJsonMetadata?.profile?.about != null)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenHorizontalPaddingDigit),
            child: Text(
              data.postingJsonMetadata!.profile!.about!,
              style: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: theme.primaryColorDark.withOpacity(0.8)),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: _manabar(context),
      ),
      if (!context.isDesktopSize &&
          controller.userBadgesController.items.isNotEmpty)
        SliverPadding(
          padding: kScreenHorizontalPadding,
          sliver: SliverToBoxAdapter(
            child: _badges(context, controller),
          ),
        ),
      SliverToBoxAdapter(
        child: UserProfileMobileTabletInfoTile(data: data),
      ),
    ]);
  }

  Padding _badges(BuildContext context, UserProfileController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 60,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: UserProfileBadges(
            displayOnlyItmes: true,
            isVertical: false,
            widgetItem: (item) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: UserProfileimage(
                  onTap: () => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => ResponsiveScrollDialog(
                          width: 200,
                          title: "Badges",
                          content: UserProfileBadges(
                            isVertical: true,
                            displayOnlyItmes: true,
                            userProfileController: controller,
                          ),
                        ),
                      ),
                  url: item.name),
            ),
          ),
        ),
      ),
    );
  }

  Padding _manabar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 18, horizontal: kScreenHorizontalPaddingDigit),
      child: ResponsiveLayout(
        gap: 10,
        isVertical: context.isMobileSize,
        children: [
          if (data.votingManabar != null)
            Padding(
              padding: EdgeInsets.only(
                  right: data.downvoteManabar != null && !context.isMobileSize
                      ? 25
                      : 0.0),
              child: UserProfileManaBar(
                  icon: Icons.thumb_up,
                  manabarColor: Colors.greenAccent.withOpacity(0.85),
                  mana: data.votingManabar!.currentMana ?? 0,
                  toolTip: 'Upvote Mana'),
            ),
          if (data.downvoteManabar != null)
            UserProfileManaBar(
                icon: Icons.thumb_down,
                manabarColor: Colors.red,
                mana: data.downvoteManabar!.currentMana ?? 0,
                toolTip: 'DownVote Mana'),
        ],
      ),
    );
  }
}
