import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/image_thumbs.dart';

class UserProfileimage extends StatelessWidget {
  const UserProfileimage(
      {super.key,
      required this.url,
      this.radius = 40,
      this.verticalPadding = 12});

  final String url;
  final double radius;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalPadding),
      height: radius,
      width: radius,
      decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
                context.userOwnerThumb(url),
              ),
              fit: BoxFit.cover)),
    );
  }
}
