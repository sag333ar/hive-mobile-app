import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/header_title.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_ranked_item.dart';

class WitnessRankedWidget extends StatelessWidget {
  const WitnessRankedWidget(
      {super.key, required this.items, this.isVerticalScroll = true});

  final List<WitnessesModel> items;
  final bool isVerticalScroll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 375,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderTitle(text: "Top 5 Witnesses"),
          const Gap(15),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(right: 15),
              itemCount: 5,
              scrollDirection:
                  isVerticalScroll ? Axis.vertical : Axis.horizontal,
              itemBuilder: (context, index) {
                WitnessesModel item = items[index];
                return WitnessRankedItem(
                  isVerticalScroll: isVerticalScroll,
                  theme: theme,
                  item: item,
                  index: index,
                );
              },
              separatorBuilder: (context, index) => const Gap(10),
            ),
          )
        ],
      ),
    );
  }
}
