import 'package:flutter/material.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/widgets/proposal_item.dart';

class ProposalWidget extends StatelessWidget {
  const ProposalWidget({super.key, required this.items});

  final List<ProposalModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          ProposalModel item = items[index];
          return ProposalItem(
            item: item,
          );
        });
  }
}
