import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_button.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/link_action_dialog.dart';

class WitnessLinkButton extends StatelessWidget {
  const WitnessLinkButton({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ColoredButton(
      onPressed: () => WitnessLinkButton.onTap(context,url),
      text: "Know more",
      icon: Icons.link,
    );
  }

  static void onTap(BuildContext context, String url) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return LinkActionDialog(link: url);
      },
    );
  }
}
