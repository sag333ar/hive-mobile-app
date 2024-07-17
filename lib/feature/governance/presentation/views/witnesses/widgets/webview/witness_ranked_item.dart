import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_vertical_divider.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/witness_item_info.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/witness_link_button.dart';

class WitnessRankedItem extends StatelessWidget {
  const WitnessRankedItem(
      {super.key,
      required this.theme,
      required this.item,
      required this.index,
      required this.isVerticalScroll});

  final ThemeData theme;
  final WitnessesModel item;
  final int index;
  final bool isVerticalScroll;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: theme.primaryColorLight,
          child: SizedBox(
            width: !isVerticalScroll ? 300 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomListTile(
                    onTap: () => context.platformPushNamed(Routes.userView,
                        pathParameters: {RouteKeys.accountName: item.owner}),
                    leading: UserProfileimage(
                      url: item.owner,
                      radius: 45,
                    ),
                    titleText: item.owner),
                Divider(
                  thickness: 3,
                  color: theme.primaryColorLight,
                ),
                WitnessItemInfo(item: item),
                if (!isVerticalScroll) const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(
                        left: kScreenHorizontalPaddingDigit,
                        right: kScreenHorizontalPaddingDigit,
                        bottom: 15,
                        top: 5),
                    child: WitnessLinkButton(
                      url: item.url,
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          right: -15,
          top: -15,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: theme.primaryColorLight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                '${index + 1}',
                style: theme.textTheme.displayLarge!.copyWith(fontSize: 30),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _verticalDivider(ThemeData theme) {
    return CustomVerticalDivider(
      height: 18,
      width: 1,
      color: theme.primaryColorDark.withOpacity(0.2),
      horizontalMargin: 5,
    );
  }
}
