import 'dart:developer';
import 'package:auth/core/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/markdown/thread_markdown.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/comment_detail_action_bar.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/comment_textfield.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/tag_scroll.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/upvote_slider.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';

class InboxDetailView extends StatefulWidget {
  const InboxDetailView(
      {super.key, required this.item, required this.controller});

  final PostFeedModel item;
  final InboxController controller;

  @override
  State<InboxDetailView> createState() => _InboxDetailViewState();
}

class _InboxDetailViewState extends State<InboxDetailView> {
  final TextEditingController commentTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    commentTextEditingController.dispose();
    super.dispose();
  }

  double weight = 10;
  @override
  Widget build(BuildContext context) {
    log(widget.item.author);
    log(widget.item.permlink);
    final theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: widget.controller,
      builder: (context, child) {
        return Scaffold(
          appBar: context.isMobileSize ? AppBar() : null,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: kScreenVerticalPadding.copyWith(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: kScreenHorizontalPadding.copyWith(bottom: 0),
                          color: theme.colorScheme.onTertiaryContainer,
                          child: UserImageName(name: widget.item.author)),
                      const Gap(5),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: kScreenHorizontalPaddingDigit),
                          color: theme.colorScheme.onTertiaryContainer,
                          child: ThreadMarkDown(item: widget.item)),
                      if (widget.item.jsonMetadata?.tags != null &&
                          widget.item.jsonMetadata!.tags!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child:
                              TagScroll(tags: widget.item.jsonMetadata!.tags!),
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(),
                      ),
                      UpvoteSlider(
                        initialWeight: weight,
                        onChanged: (weight) {
                          this.weight = weight;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(),
                      ),
                      const Text("Your comment"),
                      const Gap(8),
                      InboxCommentTextField(
                        textEditingController: commentTextEditingController,
                      ),
                      const Gap(15),
                      CommentDetailActionBar(
                          author: widget.item.author,
                          permlink: widget.item.permlink,
                          comment: commentTextEditingController.text,
                          weight: weight)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
