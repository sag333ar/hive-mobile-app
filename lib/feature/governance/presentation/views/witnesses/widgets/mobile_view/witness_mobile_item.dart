import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_list_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/link_action_dialog.dart';
import 'package:hive_mobile_app/core/common/widgets/drawer/expandable_tile.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/witness_item_info.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/witness_link_button.dart';

class WitnessMobileItem extends StatelessWidget {
  const WitnessMobileItem({super.key, required this.item, required this.index});

  final WitnessesModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpandableItem(
      isExpanded: false,
      expandedColor: theme.colorScheme.tertiaryContainer,
      header: CustomListTile(
        onTap: () => context.platformPushNamed(Routes.userView,
            pathParameters: {'accountName': item.owner}),
        padding: const EdgeInsets.only(left: kScreenHorizontalPaddingDigit),
        leading: UserProfileimage(url: item.owner),
        titleText: item.owner,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: theme.colorScheme.tertiary),
          child: Text("#${index + 1}"),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kScreenHorizontalPaddingDigit),
          child: Divider(
            thickness: 3,
            color: theme.primaryColorLight,
          ),
        ),
        WitnessItemInfo(item: item),
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
    );
  }

  void onTap(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return LinkActionDialog(link: item.url);
      },
    );
  }
}
