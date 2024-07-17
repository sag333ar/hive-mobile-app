import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/controller/user_follow_info_list_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/widgets/user_follow_info_list_item.dart';
import 'package:provider/provider.dart';

class UserFollowInfoListView extends StatelessWidget {
  const UserFollowInfoListView(
      {super.key, required this.items, required this.type});

  final List<FollowInfoModel> items;
  final FollowType type;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      padding:
          const EdgeInsets.symmetric(vertical: kScreenVerticalPaddingDigit),
      itemCount: items.length,
      itemBuilder: (context, index) {
        FollowInfoModel item = items[index];
        return Column(
          children: [
            UserFollowInfoListItem(
              item: item,
              type: type,
            ),
            if (index == items.length - 1)
              PaginationLoader(
                pageVisibilityListener: (context) =>
                    context.select<UserFollowInfoListController, bool>(
                        (value) => value.isNextPageLoading),
              )
          ],
        );
      },
      separatorBuilder: (context, index) => const Gap(2),
    );
  }
}
