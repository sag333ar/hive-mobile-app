import 'package:flutter/material.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/inbox_list_view.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/view/inbox_detail_view.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';

class WebInboxWidgetView extends StatelessWidget {
  const WebInboxWidgetView({super.key, required this.selectedPostDetailView});

  final ValueNotifier<PostFeedModel?> selectedPostDetailView;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.4,
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 475),
            child: InboxListView(
              showMasterView: true,
              selectedPostDetailView: selectedPostDetailView,
            )),
        ValueListenableBuilder(
          valueListenable: selectedPostDetailView,
          builder: (context, value, child) {
            return value != null
                ? Expanded(
                    child: InboxDetailView(
                    item: value,
                    controller: context.read<InboxController>(),
                  ))
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
