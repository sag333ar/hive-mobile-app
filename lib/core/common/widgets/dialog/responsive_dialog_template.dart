import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogTemplate extends StatelessWidget {
  const DialogTemplate({
    super.key,
    required this.title,
    required this.content,
    this.maxWidth,
  });

  final String title;
  final Widget? content;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: theme.primaryColorLight,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.displaySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.cancel))
          ],
        ),
        content: content);
  }
}
