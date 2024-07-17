import 'dart:developer';

import 'package:auth/core/extensions/ui.dart';
import 'package:auth/core/transactions/controllers/sign_transaction_posting_key_controller.dart';
import 'package:auth/core/transactions/model/sign_transaction_navigation_model.dart';
import 'package:auth/core/transactions/views/hive_sign_transaction_view.dart';
import 'package:auth/core/transactions/widgets/transaction_decision_dialog.dart';
import 'package:auth/core/utils/constants/ui_constants.dart';
import 'package:auth/core/utils/enum.dart';
import 'package:auth/feature/auth/models/user_auth/posting_auth_model.dart';
import 'package:auth/feature/auth/models/user_auth/user_auth_model.dart';
import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_button.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/markdown/thread_markdown.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/comment_textfield.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/tag_scroll.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/upvote_slider.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';
// import 'package:auth/core/transactions/sign_transaction_posting_key_controller.dart';

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
          body: SingleChildScrollView(
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
                        child: TagScroll(tags: widget.item.jsonMetadata!.tags!),
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
                    const Gap(25),
                    const Text("Your comment"),
                    const Gap(8),
                    InboxCommentTextField(
                      textEditingController: commentTextEditingController,
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        ColoredButton(text: "Reply", onPressed: comment),
                        const Gap(10),
                        ColoredButton(
                            backgroundColor: Colors.blue,
                            text: "Upvote",
                            onPressed: upvote),
                        const Spacer(),
                        ColoredButton(
                            text: "Reply and Upvote", onPressed: () {}),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void upvote() {
    final UserAuthModel userData = context.read<UserController>().userData!;
    if (weight <= 0) {
      context.showSnackBar("Please set your vote value higher than zero");
    } else {
      if (userData.isPostingKeyLogin) {
        _postingKeyVoteTransaction(userData, context);
      } else {
        _dialogForHiveTransaction(context, SignTransactionType.vote);
      }
    }
  }

  void comment() {
    final UserAuthModel userData = context.read<UserController>().userData!;
    if (commentTextEditingController.text.trim().isEmpty) {
      context.showSnackBar("Enter your comment");
    } else if (userData.isPostingKeyLogin) {
      _postingKeyCommentTransaction(userData, context);
    } else {
      _dialogForHiveTransaction(context, SignTransactionType.comment);
    }
  }

  void _postingKeyVoteTransaction(
      UserAuthModel userData, BuildContext context) async {
    context.showLoader();
    SignTransactionPostingKeyController()
        .initVoteProcess(weight * 100,
            author: widget.item.author,
            permlink: widget.item.permlink,
            authdata: userData as UserAuthModel<PostingAuthModel>,
            onSuccess: () => {},
            showToast: (message) => context.showSnackBar(message))
        .then((_) {
      context.hideLoader();
    });
  }

  void _postingKeyCommentTransaction(
      UserAuthModel<dynamic> userData, BuildContext context) async {
    context.showLoader();
    await SignTransactionPostingKeyController()
        .initCommentProcess(commentTextEditingController.text.trim(),
            author: widget.item.author,
            parentPermlink: widget.item.permlink,
            authData: userData as UserAuthModel<PostingAuthModel>,
            onSuccess: (generatedPermlink) {
              context.hideLoader();
            },
            onFailure: () => context.hideLoader(),
            showToast: (message) => context.showSnackBar(message));
  }

  Future<dynamic> _dialogForHiveTransaction(
      BuildContext context, SignTransactionType type) {
    return showDialog(
      context: context,
      barrierColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98),
      builder: (_) => TransactionDecisionDialog(
        onContinue: (authType) {
          _onTransactionDecision(authType, context, type);
        },
      ),
    );
  }

  void _onTransactionDecision(
      AuthType authType, BuildContext context, SignTransactionType type) {
    SignTransactionNavigationModel navigationData =
        SignTransactionNavigationModel(
            transactionType: type,
            author: widget.item.author,
            permlink: widget.item.permlink,
            weight: type == SignTransactionType.vote ? weight * 100 : null,
            comment: type == SignTransactionType.comment
                ? commentTextEditingController.text.trim()
                : null,
            ishiveKeyChainMethod: authType == AuthType.hiveKeyChain);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HiveSignTransactionView(
        data: navigationData,
      );
    })).then((value) {
      if (value != null) {}
    });
  }
}
