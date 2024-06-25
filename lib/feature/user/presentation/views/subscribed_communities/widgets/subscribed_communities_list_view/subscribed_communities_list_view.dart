import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/widgets/subscribed_communities_item.dart';

class SubscribedCommunitiesListView extends StatelessWidget {
  const SubscribedCommunitiesListView({
    super.key,
    required this.items,
  });

  final List<SubscribedCommunityModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: items.length,
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) => const Gap(2),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    SubscribedCommunityModel item = items[index];
    return SubscribedCommunitiesItem(
      item: item,
    );
  }
}
