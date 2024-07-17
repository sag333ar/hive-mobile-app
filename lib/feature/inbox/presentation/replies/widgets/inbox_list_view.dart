import 'package:auth/core/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/inbox_item.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';

class InboxListView extends StatelessWidget {
  const InboxListView(
      {super.key, this.selectedPostDetailView, required this.showMasterView});

  final ValueNotifier<PostFeedModel?>? selectedPostDetailView;
  final bool showMasterView;

  @override
  Widget build(BuildContext context) {
    return Selector<InboxController, List<PostFeedModel>>(
      selector: (_, myType) => myType.items,
      builder: (context, items, child) {
        if (showMasterView && selectedPostDetailView != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            selectedPostDetailView!.value = items.first;
          });
        }
        return ListView.separated(
          padding: kScreenVerticalPadding.copyWith(left: 5),
          itemCount: items.length,
          separatorBuilder: (context, index) => const Gap(4),
          itemBuilder: (context, index) {
            final PostFeedModel item = items[index];
            return InboxItem(
              item: item,
              selectedPostDetailView: selectedPostDetailView,
            );
          },
        );
      },
    );
  }
}
