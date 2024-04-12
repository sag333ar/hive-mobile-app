import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';

class ProfileLinkifyText extends StatelessWidget {
  const ProfileLinkifyText({super.key, required this.content});

  final String content;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Linkify(
      onOpen: (link) async {
        Act.launchThisUrl(link.url);
      },
      text: content,
      style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w300,
          color: theme.primaryColorDark.withOpacity(0.9)),
      linkStyle: theme.textTheme.labelLarge!.copyWith(color: Colors.blue),
    );
  }
}
