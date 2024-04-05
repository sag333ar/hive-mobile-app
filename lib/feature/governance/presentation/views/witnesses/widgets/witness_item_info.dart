import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/single_line_header_content_text.dart';
import 'package:hive_mobile_app/core/common/widgets/custom_vertical_divider.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class WitnessItemInfo extends StatelessWidget {
  const WitnessItemInfo({super.key, required this.item});

  final WitnessesModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 15, horizontal: kScreenHorizontalPaddingDigit),
      child: Wrap(
        spacing: 3,
        runSpacing: 3,
        children: [
          SingleLineHeaderContentText(
              header: "Fee",
              content: item.blockProps?.accountCreationFee ?? "Unknown"),
          _verticalDivider(theme),
          SingleLineHeaderContentText(
              header: "Blocks Missed",
              content: item.blockProps?.accountCreationFee ?? "Unknown"),
          _verticalDivider(theme),
          SingleLineHeaderContentText(
              header: "Last Block",
              content:
                  "${item.lastConfirmedBlockNum ?? "Unknown"}  •  ${timeago.format(item.lastHbdExchangeUpdate!)}"),
          _verticalDivider(theme),
          const SingleLineHeaderContentText(header: "Votes", content: "1000"),
          _verticalDivider(theme),
          SingleLineHeaderContentText(
              header: "Node Version",
              content: item.runningVersion ?? "Unknown"),
          _verticalDivider(theme),
        ],
      ),
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
