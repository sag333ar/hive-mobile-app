import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';

class ProfileMobileTabletInfoScrollTile extends StatelessWidget {
  const ProfileMobileTabletInfoScrollTile({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.color,
    this.leftPadding
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:leftPadding ?? 10.0),
      child: TextBox(
        onTap: onTap,
        borderColor: color,
        showBorder: true,
        mainAxisAlignment: MainAxisAlignment.center,
        borderRadius: 40,
        icon: icon,
        padding: const EdgeInsets.symmetric(
            horizontal: kScreenHorizontalPaddingDigit, vertical: 5),
        backgroundColor: Colors.transparent,
        text: text,
      ),
    );
  }
}
