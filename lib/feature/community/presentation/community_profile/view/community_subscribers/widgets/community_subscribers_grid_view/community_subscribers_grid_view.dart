import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/controller/community_subscribers_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/widgets/community_subscribers_list_item.dart';
import 'package:provider/provider.dart';

class CommunitySubscribersGridView extends StatelessWidget {
  const CommunitySubscribersGridView(
      {super.key,
      required this.items,
      required this.screenWidth,
      required this.isSliver,
      this.decrementWidth,
      this.itemColor, this.popOnTap});

  final List<CommunityMemberModel> items;
  final double? screenWidth;
  final bool isSliver;
  final double? decrementWidth;
  final Color? itemColor;
  final bool? popOnTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      childAspectRatio: 7,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      decrementedWidth: decrementWidth,
      isSliver: isSliver,
      screenWidth: screenWidth,
      itemCount: items.length,
      itemBuilder: (context, index) {
        CommunityMemberModel item = items[index];
        return CommunitySubscribersListItem(
          item: item,
          color: itemColor,
          popOnTap: popOnTap,
        );
      },
      paginationLoader: PaginationLoader(
        pageVisibilityListener: (context) =>
            context.select<CommunitySubscribersListController, bool>(
                (value) => value.isNextPageLoading),
      ),
    );
  }
}
