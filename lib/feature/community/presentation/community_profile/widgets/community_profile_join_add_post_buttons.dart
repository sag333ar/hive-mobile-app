import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/buttons/duo_text_buttons.dart';

class CommunityProfileJoinAddPostButtons extends StatelessWidget {
  const CommunityProfileJoinAddPostButtons({super.key, this.buttonHeight});

  final double? buttonHeight;

  @override
  Widget build(BuildContext context) {
    return DuoTextButtons(
        buttonHeight: buttonHeight,
        buttonOneText: 'Join',
        buttonTwoText: 'New Post',
        buttonOneOnTap: () {},
        buttonTwoOnTap: () {});
  }
}
