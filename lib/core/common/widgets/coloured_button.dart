import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({super.key, required this.text, this.icon, required this.onPressed});

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 30,
      child: FilledButton(
          style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: theme.primaryColor),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(icon!=null)  Padding(
                padding: const EdgeInsets.only(right :10.0),
                child: Icon(icon),
              ),
              Text(
                text,
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ],
          )),
    );
  }
}
