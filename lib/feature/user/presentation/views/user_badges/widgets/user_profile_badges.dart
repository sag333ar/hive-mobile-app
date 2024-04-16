import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/badge_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_badges/controller/badges_controller.dart';
import 'package:provider/provider.dart';

class UserProfileBadges extends StatelessWidget {
  const UserProfileBadges(
      {super.key,
      this.widgetItem,
      this.userProfileController,
      this.isVertical = true,
      this.displayOnlyItmes = false});

  final Widget Function(BadgeModel item)? widgetItem;
  final UserProfileController? userProfileController;
  final bool isVertical;
  final bool displayOnlyItmes;

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
              return _dataState(items, theme, context);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  Visibility _dataState(
      List<BadgeModel> items, ThemeData theme, BuildContext context) {
    return Visibility(
        visible: items.isNotEmpty, child: _itemWidget(items, theme));
  }

  Widget _itemWidget(List<BadgeModel> items, ThemeData theme) {
    if (isVertical && !displayOnlyItmes) {
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
    } else if (isVertical && displayOnlyItmes) {
      return Column(children: _badges(items, theme));
    } else {
      return Row(
        children: _badges(items, theme),
      );
    }
  }

  List<Widget> _badges(List<BadgeModel> items, ThemeData theme) {
    return List.generate(
      items.length,
      (index) {
        BadgeModel item = items[index];
        return widgetItem != null
            ? widgetItem!(item)
            : UserImageName(
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
