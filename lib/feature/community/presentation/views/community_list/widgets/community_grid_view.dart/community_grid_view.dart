import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/controller/community_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/widgets/community_item.dart';
import 'package:provider/provider.dart';

class CommunityGridView extends StatelessWidget {
  const CommunityGridView({
    super.key,
    required this.items,
  });

  final List<CommunityModel> items;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
        childAspectRatio: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemCount: items.length,
        itemBuilder: (context, index) {
          CommunityModel item = items[index];
          return CommunityItem(
            item: item,
          );
        },
        paginationLoader: PaginationLoader(
          pageVisibilityListener: (context) =>
              context.select<CommunityListController, bool>(
                  (value) => value.isNextPageLoading),
        ),);
  }
}
