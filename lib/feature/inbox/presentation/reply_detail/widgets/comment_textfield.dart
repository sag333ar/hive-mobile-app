import 'package:flutter/material.dart';

class InboxCommentTextField extends StatelessWidget {
  const InboxCommentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      maxLines: 20,
      minLines: 6,
      decoration: InputDecoration(
          fillColor: theme.colorScheme.tertiary,
          filled: true,
          hintText: "Type your reply here...",
          border: outLineBorder,
          errorBorder: outLineBorder,
          enabledBorder: outLineBorder,
          focusedBorder: outLineBorder,
          disabledBorder: outLineBorder,
          focusedErrorBorder: outLineBorder),
    );
  }

  OutlineInputBorder get outLineBorder {
    return const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }
}
