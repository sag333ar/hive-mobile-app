import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:intl/intl.dart';

class ProposalItem extends StatelessWidget {
  const ProposalItem({super.key, required this.item});

  final ProposalModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isActive = item.endDate.isAfter(DateTime.now());
    String startDate = DateFormat('d MMM, yyyy').format(item.startDate);
    String endDate = DateFormat('d MMM, yyyy').format(item.endDate);
    String totalDays = "${item.endDate.difference(item.startDate).inDays} days";
    int remainingDays = item.endDate.difference(DateTime.now()).inDays;

    return Stack(
      children: [
        Card(
          color: theme.primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.only(
                left: kScreenHorizontalPaddingDigit,
                right: kScreenHorizontalPaddingDigit,
                bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserImageName(
                      onTap: () => context.platformPushNamed(Routes.userView,
                          pathParameters: {'accountName': item.creator}),
                      name: item.creator,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.isMobile ? 8 : 15),
                      child: const Divider(),
                    )),
                    UserImageName(
                       onTap: () => context.platformPushNamed(Routes.userView,
                          pathParameters: {'accountName': item.receiver}),
                      reverse: true,
                      name: item.receiver,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.subject,
                            style: theme.textTheme.bodyLarge,
                          ),
                          _intervalSubTile(
                              startDate, theme, endDate, totalDays),
                          const Gap(15),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TextBox(
                                  backgroundColor:
                                      isActive ? Colors.green : Colors.red,
                                  text: isActive ? "Active" : "Expired",
                                  textColor: theme.colorScheme.onPrimary,
                                ),
                                const Gap(5),
                                TextBox(
                                    backgroundColor: theme.primaryColor,
                                    textColor: theme.colorScheme.onPrimary,
                                    text: item.dailyPay),
                                const Gap(5),
                                TextBox(
                                  backgroundColor:
                                      theme.colorScheme.tertiaryContainer,
                                  text: "1000",
                                  showBorder: true,
                                  icon: Icons.thumb_up,
                                ),
                                const Gap(2),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.link,
                                      color: Colors.blue,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!context.isMobile) _daysLeftWidget(theme, remainingDays)
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 8,
            right: 15,
            child: Visibility(
              visible: context.isMobile,
              child: Text(
                "$remainingDays days left",
                style: theme.textTheme.labelMedium,
              ),
            ))
      ],
    );
  }

  Row _intervalSubTile(
      String startDate, ThemeData theme, String endDate, String totalDays) {
    return Row(
      children: [
        Text(
          "$startDate - ",
          style: dateTextStyle(theme),
        ),
        Text(
          "$endDate ",
          style: dateTextStyle(theme),
        ),
        Text(
          "($totalDays)",
          style: dateTextStyle(theme)
              .copyWith(color: theme.primaryColorDark.withOpacity(0.4)),
        ),
      ],
    );
  }

  Container _daysLeftWidget(ThemeData theme, int remainingDays) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: theme.primaryColorLight,
        border: Border.all(color: theme.colorScheme.tertiaryContainer),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Text(
            "$remainingDays",
            style: theme.textTheme.displayMedium!.copyWith(fontSize: 25),
          ),
          Text(
            "Days Left",
            style: theme.textTheme.labelSmall!.copyWith(
              color: theme.primaryColorDark.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }

  TextStyle dateTextStyle(ThemeData theme) {
    return theme.textTheme.labelLarge!.copyWith(
        color: theme.primaryColorDark.withOpacity(
          0.7,
        ),
        fontWeight: FontWeight.w300);
  }
}
