import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/dense_icon_button.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';

class BookmarkIcon extends StatefulWidget {
  const BookmarkIcon({super.key, required this.item});

  final PostFeedModel item;

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = context
        .read<InboxController>()
        .isBookmarked(widget.item.author, widget.item.permlink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<InboxController>();
    return DenseIconButton(
      onPressed: () {
        setState(() {
          if (mounted) {
            controller.toggleBookmark(!isBookmarked, widget.item);
            isBookmarked = !isBookmarked;
          }
        });
      },
      icon: isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
    );
  }
}
