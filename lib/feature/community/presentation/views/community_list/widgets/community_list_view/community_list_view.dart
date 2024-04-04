import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/pagination_loader.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/controller/community_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/widgets/community_item.dart';
import 'package:provider/provider.dart';

class CommunityListView extends StatelessWidget {
  const CommunityListView({super.key, required this.items});

  final List<CommunityModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      padding:
          const EdgeInsets.symmetric(vertical: kScreenVerticalPaddingDigit),
      itemCount: items.length,
      itemBuilder: (context, index) {
        CommunityModel item = items[index];
        return Column(
          children: [
            CommunityItem(item: item),
            if(index == items.length -1 ) PaginationLoader(
              pageVisibilityListener: (context) =>
                  context.select<CommunityListController, bool>(
                      (value) => value.isNextPageLoading),
            )
          ],
        );
      },
      separatorBuilder: (context, index) =>  const Gap(2),
    );
  }
}
