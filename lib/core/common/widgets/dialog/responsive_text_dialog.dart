import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/responsive_dialog_template.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/widgets/profile_linkify_text.dart';

class ResponsiveTextDialog extends StatelessWidget {
  const ResponsiveTextDialog({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DialogTemplate(
      title: title,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400, maxHeight: screenHeight),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20).copyWith(bottom: 30),
            child: ProfileLinkifyText(content: content)),
      ),
    );
  }
}
