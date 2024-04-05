import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/controller/witnesses_controller.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/mobile_view/witness_mobile_item.dart';
import 'package:provider/provider.dart';

class WitnessMobileWidget extends StatelessWidget {
  const WitnessMobileWidget({super.key, required this.items});

  final List<WitnessesModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          WitnessesModel item = items[index];
          return Column(
            children: [
              WitnessMobileItem(
                item: item,
                index: index,
              ),
              if (index == items.length - 1)
                PaginationLoader(
                    pageVisibilityListener: (context) =>
                        context.select<WitnessController, bool>(
                            (value) => value.isNextPageLoading))
            ],
          );
        });
  }
}
