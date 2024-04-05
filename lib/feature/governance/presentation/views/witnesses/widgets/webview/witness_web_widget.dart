import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_web_list_view.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_ranked_widget.dart';

class WitnessWebWidget extends StatelessWidget {
  const WitnessWebWidget({super.key, required this.items});

  final List<WitnessesModel> items;

  static const borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WitnessRankedWidget(items: items),
        const Gap(5),
        Expanded(
            child: WitnessWebListView(
          items: items,
        )),
      ],
    );
  }
}
