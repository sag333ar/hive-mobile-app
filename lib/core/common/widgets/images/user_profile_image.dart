import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/image_thumbs.dart';
import 'package:hive_mobile_app/core/common/widgets/inkwell_wrapper.dart';

class UserProfileimage extends StatelessWidget {
  const UserProfileimage(
      {super.key,
      required this.url,
      this.radius,
      this.verticalPadding = 12,
      this.resize = false,
      this.fit,
      this.onTap});

  final String url;
  final double? radius;
  final double verticalPadding;
  final BoxFit? fit;
  final bool resize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: onTap,
      borderRadius:
          onTap != null ? const BorderRadius.all(Radius.circular(100)) : null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalPadding),
        height: radius ?? 40,
        width: radius ?? 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
                resize
                    ? context.resizedImage(context.userOwnerThumb(url),
                        height: height, width: width)
                    : context.userOwnerThumb(url),
              ),
              fit: fit ?? BoxFit.cover),
        ),
      ),
    );
  }

  int? get width {
    if (radius == null) {
      return null;
    } else {
      return radius!.toInt() * 10;
    }
  }

  int? get height {
    if (radius == null) {
      return null;
    } else {
      return radius!.toInt() * 6;
    }
  }
}
