import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_scroll_dialog.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/badge_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_badges/controller/badges_controller.dart';
import 'package:provider/provider.dart';

class UserProfileBadges extends StatelessWidget {
  const UserProfileBadges(
      {super.key,
      this.userProfileController,
      this.isVertical = true,
      this.displayOnlyItmes = false,
      this.displayOnlyFirstItem = false});

  final UserProfileController? userProfileController;
  final bool isVertical;
  final bool displayOnlyItmes;
  final bool displayOnlyFirstItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProfileController =
        this.userProfileController ?? context.read<UserProfileController>();
    return ChangeNotifierProvider.value(
      value: userProfileController.userBadgesController,
      builder: (context, child) {
        final controller = context.read<UserBadgesController>();
        return Selector<UserBadgesController, ViewState>(
          selector: (_, provider) => provider.viewState,
          builder: (context, state, child) {
            if (state == ViewState.data) {
              List<BadgeModel> items = controller.items;
              if (isVertical) {
                return _itemWidget(items, theme);
              } else if (items.length == 1 && displayOnlyFirstItem) {
                return _singleItem(context, userProfileController, items, theme);
              } else if (items.length != 1 && !displayOnlyFirstItem) {
                return _horizontalItemWidget(
                    items, context, userProfileController);
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  InkWellWrapper _singleItem(BuildContext context, UserProfileController userProfileController, List<BadgeModel> items, ThemeData theme) {
    return InkWellWrapper(
                onTap: () => _onTapItem(context, userProfileController),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  child: Row(
                    children: [
                      UserProfileimage(radius: 20, url: items.first.name),
                      const Gap(5),
                      TextBox(
                        text: "Badges",
                        borderRadius: 12,
                        backgroundColor:
                            theme.primaryColorLight.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              );
  }

  Padding _horizontalItemWidget(List<BadgeModel> items, BuildContext context,
      UserProfileController userProfileController) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 10.0,
          left: kScreenHorizontalPaddingDigit,
          right: kScreenHorizontalPaddingDigit),
      child: SizedBox(
        height: 60,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: List.generate(
                  items.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _horizontalItem(
                        context, userProfileController, items, index),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  UserProfileimage _horizontalItem(
      BuildContext context,
      UserProfileController userProfileController,
      List<BadgeModel> items,
      int index) {
    return UserProfileimage(
        onTap: () => _onTapItem(context, userProfileController),
        url: items[index].name);
  }

  Future<dynamic> _onTapItem(
      BuildContext context, UserProfileController userProfileController) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ResponsiveScrollDialog(
        width: 200,
        title: "Badges",
        content: UserProfileBadges(
          isVertical: true,
          displayOnlyItmes: true,
          userProfileController: userProfileController,
        ),
      ),
    );
  }

  Widget _itemWidget(
    List<BadgeModel> items,
    ThemeData theme,
  ) {
    if (!displayOnlyItmes) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(),
          ),
          Text(
            "Badges",
            style: theme.textTheme.displaySmall,
          ),
          const Gap(10),
          Column(children: _badges(items, theme))
        ],
      );
    } else {
      return Column(children: _badges(items, theme));
    }
  }

  List<Widget> _badges(List<BadgeModel> items, ThemeData theme) {
    return List.generate(
      items.length,
      (index) {
        BadgeModel item = items[index];
        return UserImageName(
          maxLines: 2,
          isExpanded: true,
          textStyle: theme.textTheme.labelLarge,
          name: item.name,
          displayName: item.title,
        );
      },
    );
  }
}
