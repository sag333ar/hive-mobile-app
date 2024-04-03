import 'package:flutter/material.dart';

class Emptystate extends StatelessWidget {
  const Emptystate(
      {super.key,
      required this.text,
      this.icon,
      this.showButton = false,
      this.onPressed,
      this.buttonText = ""})
      : assert(
            !(showButton && onPressed == null), "OnTap call back is required");

  final String text;
  final IconData? icon;
  final bool showButton;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: icon != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Icon(
              icon,
              size: 100,
              color: theme.primaryColorDark,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(text,
              textAlign: TextAlign.center, style: theme.textTheme.displaySmall),
        ),
        showButton
            ? Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      height: 28,
                      child: OutlinedButton(
                        onPressed: onPressed,
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          side: BorderSide(
                            color: theme.primaryColorDark,
                          ),
                        ),
                        child: Text(
                          buttonText,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: theme.primaryColorLight),
                        ),
                      ),
                    )),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
