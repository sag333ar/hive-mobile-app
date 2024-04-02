import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/image_thumbs.dart';
import 'package:hive_mobile_app/feature/feeds/models/post_feed_model.dart';
import 'package:hive_mobile_app/gen/assets.gen.dart';

class PostImage extends StatelessWidget {
  const PostImage(
      {super.key,
      required this.item,
      required this.height,
      required this.width,
      this.verticalPadding = 8});

  final PostFeedModel item;
  final double height;
  final double width;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    String? image = item.jsonMetadata?.image?.firstOrNull;
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.tertiary,
      height: height,
      width: width,
      child: Stack(
        children: [
          if (image != null && image.isNotEmpty)
            Image.network(
              context.resizedImage(image),
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          if (image != null && image.isNotEmpty)
            Positioned.fill(
              top: -2,
              bottom: -2,
              left: -2,
              right: -2,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: verticalPadding),
            height: height,
            width: width,
            child: item.jsonMetadata?.image?.isNotEmpty == true
                ? _imageThumb(image ?? "", width, context)
                : _errorIndicator(width),
          ),
        ],
      ),
    );
  }

  Widget _imageThumb(String url, double width, BuildContext context) {
    return FadeInImage.assetNetwork(
      fit: BoxFit.contain,
      placeholder: "",
      image: context.resizedImage(url),
      placeholderErrorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const SizedBox.shrink();
      },
      imageErrorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return _errorIndicator(width);
      },
    );
  }

  Widget _errorIndicator(double width) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(
            Assets.images.hiveSymbolLogo.path,
          ).image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
