import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/widgets/subscribed_communities_item.dart';

class SubscribedCommunitiesGridView extends StatelessWidget {
  const SubscribedCommunitiesGridView(
      {super.key,
      required this.items,
      required this.screenWidth,
      this.decrementWidth,});

  final List<SubscribedCommunityModel> items;
  final double? screenWidth;
  final double? decrementWidth;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      childAspectRatio: 7,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      decrementedWidth: decrementWidth,
      isSliver: true,
      screenWidth: screenWidth,
      itemCount: items.length,
      itemBuilder: (context, index) {
        SubscribedCommunityModel item = items[index];
        return SubscribedCommunitiesItem(
          item: item,
        );
      },
    );
  }
}
