// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/markdown/markdown_image.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:markdown/markdown.dart' as md;

class RawImageElementBuilder extends MarkdownElementBuilder {
  final ThemeData theme;
  final PostFeedModel item;
  RawImageElementBuilder({required this.theme, required this.item});

  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    if (element.tag.isNotEmpty &&
        element.tag == 'rawImage' &&
        element.textContent.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: MarkdownImage(
          item: item,
          theme: theme,
          image: element.textContent,
        ),
      );
    }
    return super.visitElementAfterWithContext(
        context, element, preferredStyle, parentStyle);
  }
}
