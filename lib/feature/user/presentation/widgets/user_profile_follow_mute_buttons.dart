import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserProfileFollowMuteButtons extends StatelessWidget {
  const UserProfileFollowMuteButtons({super.key, this.buttonHeight});

  final double? buttonHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          height: buttonHeight,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: theme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            onPressed: () {},
            child: Text(
              'Follow',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        ),
        const Gap(10),
        SizedBox(
          height: buttonHeight,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: theme.primaryColor),
            onPressed: () {},
            child: Text(
              'Mute',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
