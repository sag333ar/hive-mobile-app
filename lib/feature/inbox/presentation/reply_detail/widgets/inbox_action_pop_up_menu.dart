import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/dense_icon_button.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';

class InboxActionPopUpMenuButton extends StatelessWidget {
  const InboxActionPopUpMenuButton({
    super.key, required this.item,
  });

  final PostFeedModel item;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<InboxController>();
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'option1',
          child: Text(
            'Report',
            style: TextStyle(color: Colors.red),
          ),
        ),
        PopupMenuItem<String>(
          value: 'option1',
          child: DenseIconButton(
            onPressed: () {
              controller.ignoreAuthor(item.author);
            },
            icon: Icons.block,
            color: Colors.red,
          ),
        ),
      ],
      onSelected: (String value) {
        switch (value) {
          case 'option1':
            break;
        }
      },
      child: const Icon(Icons.more_vert),
    );
  }
}
