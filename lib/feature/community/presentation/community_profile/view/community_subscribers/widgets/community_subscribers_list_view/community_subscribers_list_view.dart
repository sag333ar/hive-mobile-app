import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/controller/community_subscribers_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/widgets/community_subscribers_list_item.dart';
import 'package:provider/provider.dart';

class CommunitySubscribersListView extends StatelessWidget {
  const CommunitySubscribersListView(
      {super.key, required this.items, required this.isSliver, this.popOnTap});

  final List<CommunityMemberModel> items;
  final bool isSliver;
  final bool? popOnTap;

  @override
  Widget build(BuildContext context) {
    return isSliver
        ? SliverList.separated(
            itemCount: items.length,
            itemBuilder: itemBuilder,
            separatorBuilder: (context, index) => const Gap(2),
          )
        : ListView.separated(
            controller: ScrollController(),
            padding: const EdgeInsets.symmetric(
                vertical: kScreenVerticalPaddingDigit),
            itemCount: items.length,
            itemBuilder: itemBuilder,
            separatorBuilder: (context, index) => const Gap(2),
          );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    CommunityMemberModel item = items[index];
    return Column(
      children: [
        CommunitySubscribersListItem(
          item: item,
          popOnTap: popOnTap,
        ),
        if (index == items.length - 1 && !isSliver)
          PaginationLoader(
            pageVisibilityListener: (context) =>
                context.select<CommunitySubscribersListController, bool>(
                    (value) => value.isNextPageLoading),
          )
      ],
    );
  }
}
