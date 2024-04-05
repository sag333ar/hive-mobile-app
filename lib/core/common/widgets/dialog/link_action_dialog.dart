import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/widgets/dialog/dialog_button.dart';
import 'package:url_launcher/link.dart';

class LinkActionDialog extends StatelessWidget {
  const LinkActionDialog({super.key, required this.link});

  final String link;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
      backgroundColor: theme.primaryColorLight,
      title: Text(
        "Open Link",
        style: theme.textTheme.displaySmall,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                textWidthBasis: TextWidthBasis.longestLine,
                text: TextSpan(
                  text: "Do you want to open ",
                  style: theme.textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                        text: link,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.primaryColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        DialogButton(text: "No", onPressed: () => context.pop()),
        Link(
          uri: Uri.parse(link),
          builder: (context, followLink) => DialogButton(
            text: "Yes",
            onPressed: () async {
              followLink!.call();
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
