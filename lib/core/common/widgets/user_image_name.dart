import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';

class UserImageName extends StatelessWidget {
  const UserImageName(
      {super.key,
      required this.name,
      this.onTap,
      this.imageRadius,
      this.reverse = false,
      this.textStyle});

  final String name;
  final VoidCallback? onTap;
  final double? imageRadius;
  final bool reverse;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              !reverse ? _userProfileImage() : _userText(),
              const Gap(15),
              !reverse ? _userText() : _userProfileImage(),
            ],
          ),
        ),
      ),
    );
  }

  AutoSizeText _userText() => AutoSizeText(
        name,
        style: textStyle,
        maxLines: 1,
        minFontSize: 11,
        overflow: TextOverflow.ellipsis,
      );

  UserProfileimage _userProfileImage() {
    return UserProfileimage(
      url: name,
      radius: imageRadius,
    );
  }
}
