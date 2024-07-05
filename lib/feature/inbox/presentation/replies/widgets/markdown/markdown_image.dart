import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/image_thumbs.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';

class MarkdownImage extends StatelessWidget {
  const MarkdownImage({
    super.key,
    required this.item,
    required this.theme,
    required this.image,
  });

  final PostFeedModel item;
  final ThemeData theme;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Image.network(
            context.proxyImage(image),
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                frame == null
                    ? Container(
                        color: theme.colorScheme.tertiary,
                        height: 250,
                        width: double.infinity,
                        child: child,
                      )
                    : child,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress?.cumulativeBytesLoaded !=
                        loadingProgress?.expectedTotalBytes
                    ? Container(
                        color: theme.colorScheme.tertiary,
                        height: 250,
                        width: double.infinity,
                        child: child,
                      )
                    : child,
          )),
    );
  }
}
