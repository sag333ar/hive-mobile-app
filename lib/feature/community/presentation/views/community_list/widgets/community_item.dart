import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';
import 'package:hive_mobile_app/core/common/widgets/user_profile_image.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';

class CommunityItem extends StatelessWidget {
  const CommunityItem({super.key, required this.item});

  final CommunityModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: () {
        
      },
      child: Container(
        color: theme.primaryColorLight,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserProfileimage(
              url: item.name,
            ),
            const Gap(12.5),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const Gap(20),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
