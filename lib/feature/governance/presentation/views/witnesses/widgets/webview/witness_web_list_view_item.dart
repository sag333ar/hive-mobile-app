import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_vertical_divider.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/witness_link_button.dart';

class WitnessWebListViewItem extends StatelessWidget {
  const WitnessWebListViewItem(
      {super.key, required this.item, required this.index});

  final WitnessesModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Color.fromARGB(255, 11, 11, 11),
      color: theme.colorScheme.tertiaryContainer,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                    left: context.isTabletSize ? 10 : 20, right: 15),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 120, maxWidth: double.infinity),
                  child: AutoSizeText(
                    "${index + 1}",
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: itemTextStyle(theme),
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                const CustomVerticalDivider(),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 5, right: 15),
                    onTap: () {
                      context.platformPushNamed(Routes.userView,
                          pathParameters: {RouteKeys.accountName: item.owner});
                    },
                    leading: UserProfileimage(
                      url: item.owner,
                    ),
                    title: AutoSizeText(
                      item.owner,
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: itemTextStyle(theme),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.link),
                      color: Colors.blue,
                      onPressed: () =>
                          WitnessLinkButton.onTap(context, item.url),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _tile(theme, '${index + 1000}'),
          _tile(
            theme,
            item.blockProps?.accountCreationFee ?? 'Unknown',
          ),
          _tile(
            theme,
            item.totalMissed.toString(),
          ),
          _tile(theme, item.runningVersion ?? "Unknown",
              leading: Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,
                  ),
                  CircleAvatar(
                    radius: 2.5,
                    backgroundColor: theme.primaryColorLight,
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _tile(ThemeData theme, String text, {Widget? leading}) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          const CustomVerticalDivider(),
          const Gap(kScreenHorizontalPaddingDigit),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(right: kScreenHorizontalPaddingDigit),
              child: Row(
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: leading,
                    ),
                  Expanded(
                    child: AutoSizeText(
                      text,
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: itemTextStyle(theme),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle itemTextStyle(ThemeData theme) {
    return theme.textTheme.bodyMedium!;
  }
}
