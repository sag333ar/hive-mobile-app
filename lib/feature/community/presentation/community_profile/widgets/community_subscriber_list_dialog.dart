import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/view/community_subscribers_list_widget.dart';

class CommunitySubscribersListDialog extends StatelessWidget {
  const CommunitySubscribersListDialog(
      {super.key,
      required this.count,
      required this.communityId,
      });

  final int count;
  final String communityId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Subscribers ($count)',
                  style: theme.textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: SizedBox(
                height: screenHeight - 100,
                width: 750,
                child: CommunitySubscribersListWidget(
                  communityId: communityId,
                  removeScaffold: true,
                  count: count,
                  screenWidth: 750,
                )),
          ),
        );
     
  }
}
