import 'package:flutter/material.dart';

class UpVotePercentageButtons extends StatelessWidget {
  const UpVotePercentageButtons(
      {super.key, required this.onTap, required this.percentageValue});

  final Function(double) onTap;
  final double percentageValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onTap(percentageValue);
        },
        child: CircleAvatar(
          radius: 20,
          child: Text("${(percentageValue).round()}",
              style: theme.textTheme.bodyMedium),
        ),
      ),
    );
  }
}
