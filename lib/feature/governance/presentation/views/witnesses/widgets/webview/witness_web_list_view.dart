import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/controller/witnesses_controller.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_web_list_view_item.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_web_widget.dart';
import 'package:provider/provider.dart';

class WitnessWebListView extends StatelessWidget {
  const WitnessWebListView(
      {super.key, required this.items, this.isSliver = false});

  final List<WitnessesModel> items;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return !isSliver
        ? ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(context, index, theme),
            separatorBuilder: (context, index) => const Gap(1),
          )
        : SliverList.separated(
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(context, index, theme),
            separatorBuilder: (context, index) => const Gap(1),
          );
  }

  Widget itemBuilder(BuildContext context, int index, ThemeData theme) {
    WitnessesModel item = items[index];
    return Column(
      children: [
        if (index == 0) _tableHeader(theme),
        WitnessWebListViewItem(index: index, item: item),
        if (index == items.length - 1)
          PaginationLoader(
              pageVisibilityListener: (context) =>
                  context.select<WitnessController, bool>(
                      (value) => value.isNextPageLoading))
      ],
    );
  }

  Container _tableHeader(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(WitnessWebWidget.borderRadius),
              topRight: Radius.circular(WitnessWebWidget.borderRadius))),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          _header(theme, "Rank", flex: 1),
          _header(theme, "Witness", flex: 4, leftPadding: 15),
          _header(theme, "Votes"),
          _header(
            theme,
            "Fee",
          ),
          _header(
            theme,
            "Missed",
          ),
          _header(
            theme,
            "Version",
          ),
        ],
      ),
    );
  }

  Widget _header(ThemeData theme, String text,
      {double leftPadding = kScreenHorizontalPaddingDigit, int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: AutoSizeText(
          text,
          maxLines: 1,
          minFontSize: 14,
          overflow: TextOverflow.ellipsis,
          style: headingTextStyle(theme),
        ),
      ),
    );
  }

  TextStyle headingTextStyle(ThemeData theme) {
    return theme.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold);
  }
}
