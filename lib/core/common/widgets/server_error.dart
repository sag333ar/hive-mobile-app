import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';

class ErrorState extends StatelessWidget {
  const ErrorState(
      {super.key,
      this.showRetryButton = false,
      this.onTapRetryButton,
      this.isSliver = false});

  final bool showRetryButton;
  final Function()? onTapRetryButton;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isSliver
        ? SliverFillRemaining(
            child: _widget(theme),
          )
        : _widget(theme);
  }

  Center _widget(ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
              bottom: 70,
              left: kScreenHorizontalPaddingDigit,
              right: kScreenHorizontalPaddingDigit),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.error,
                color: theme.primaryColorDark,
                size: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Sorry, we're unable to reach our server",
                style: theme.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              showRetryButton
                  ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onTapRetryButton,
                      child: Text(
                        "Try Again",
                        style: theme.textTheme.displaySmall!
                            .copyWith(color: theme.primaryColor),
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
