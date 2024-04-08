import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/user_profile_image.dart';

class UserImageName extends StatelessWidget {
  const UserImageName(
      {super.key,
      required this.name,
      this.onTap,
      this.imageRadius,
      this.reverse = false});

  final String name;
  final VoidCallback? onTap;
  final double? imageRadius;
  final bool reverse;

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

  Text _userText() => Text(name);

  UserProfileimage _userProfileImage() {
    return UserProfileimage(
      url: name,
      radius: imageRadius,
    );
  }
}
