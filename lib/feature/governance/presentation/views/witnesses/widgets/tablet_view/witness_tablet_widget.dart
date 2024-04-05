import 'package:flutter/material.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_web_list_view.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_ranked_widget.dart';

class WitnessTabletWidget extends StatelessWidget {
  const WitnessTabletWidget({super.key, required this.items});

  final List<WitnessesModel> items;

  static const borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
              height: 300,
              child:
                  WitnessRankedWidget(isVerticalScroll: false, items: items)),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox.shrink(),
          ),
        ),
        WitnessWebListView(
          isSliver: true,
          items: items,
        ),
      ],
    );
  }
}
