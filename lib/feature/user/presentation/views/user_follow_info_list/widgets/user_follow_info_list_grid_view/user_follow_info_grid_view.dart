import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/common/widgets/responsive_grid_view.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/controller/user_follow_info_list_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/widgets/user_follow_info_list_item.dart';
import 'package:provider/provider.dart';

class UserFollowInfoListGridView extends StatelessWidget {
  const UserFollowInfoListGridView({
    super.key,
    required this.items,
    required this.type,
    required this.screenWidth
  });

  final List<FollowInfoModel> items;
  final FollowType type;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      childAspectRatio: 7,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      screenWidth: screenWidth,
      itemCount: items.length,
      itemBuilder: (context, index) {
        FollowInfoModel item = items[index];
        return UserFollowInfoListItem(
          item: item,
          type: type,
        );
      },
      paginationLoader: PaginationLoader(
        pageVisibilityListener: (context) =>
            context.select<UserFollowInfoListController, bool>(
                (value) => value.isNextPageLoading),
      ),
    );
  }
}
