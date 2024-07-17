import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';

class ProfileMenuTemplate extends StatelessWidget {
  const ProfileMenuTemplate({
    super.key,
    required this.urlName,
    required this.displayName,
    required this.description,
    this.profileImageFooter,
    required this.children,
  });

  final String urlName;
  final String displayName;
  final String? description;
  final Widget? profileImageFooter;
  final List<Widget> children;

  static const double width = 320.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: kScreenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: theme.colorScheme.onTertiaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          UserProfileimage(
                            fit: BoxFit.contain,
                            url: urlName,
                            radius: 100,
                          ),
                          if (profileImageFooter != null)
                            Positioned(
                                bottom: 10,
                                right: 0,
                                child: profileImageFooter!)
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0)
                        .copyWith(left: 10, right: 10),
                    child: AutoSizeText(
                      description!,
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      minFontSize: 11,
                      style: theme.textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: theme.primaryColorDark.withOpacity(0.9),
                      ),
                    ),
                  ),
                const Gap(15)
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          )
        ],
      ),
    );
  }
}
