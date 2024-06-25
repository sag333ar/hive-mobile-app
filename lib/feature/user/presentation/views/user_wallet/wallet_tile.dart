import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WalletTile extends StatelessWidget {
  const WalletTile(
      {super.key,
      required this.title,
      required this.content,
      required this.value,
      this.subContent,
      this.subTitle,
      this.isExpand = false});

  final String title;
  final String? subTitle;
  final String content;
  final String? subContent;
  final String value;
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    bool isExpand = this.isExpand && MediaQuery.of(context).size.width > 1300;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.5)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [theme.primaryColorLight, theme.colorScheme.tertiary]),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.displaySmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      if (subTitle != null)
                        AutoSizeText(
                          subTitle!,
                          minFontSize: 11,
                          style: theme.textTheme.displaySmall!
                              .copyWith(color: Colors.green),
                        ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          content,
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.primaryColorDark.withOpacity(0.8)),
                        ),
                      ),
                      if (isExpand)
                        const Expanded(flex: 1, child: SizedBox.shrink())
                    ],
                  ),
                  if (subContent != null && subContent!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        subContent!,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  theme.primaryColor,
                  theme.primaryColor.withOpacity(0.5)
                ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: theme.textTheme.displayMedium!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
