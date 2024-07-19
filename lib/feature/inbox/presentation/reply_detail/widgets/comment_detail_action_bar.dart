import 'package:auth/core/extensions/ui.dart';
import 'package:auth/core/transactions/controllers/sign_transaction_posting_key_controller.dart';
import 'package:auth/core/transactions/model/sign_transaction_navigation_model.dart';
import 'package:auth/core/transactions/views/hive_sign_transaction_view.dart';
import 'package:auth/core/transactions/widgets/transaction_decision_dialog.dart';
import 'package:auth/core/utils/enum.dart';
import 'package:auth/feature/auth/models/user_auth/posting_auth_model.dart';
import 'package:auth/feature/auth/models/user_auth/user_auth_model.dart';
import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/coloured_button.dart';
import 'package:hive_mobile_app/core/common/widgets/outline_button.dart';
import 'package:provider/provider.dart';

class CommentDetailActionBar extends StatefulWidget {
  const CommentDetailActionBar(
      {super.key,
      required this.author,
      required this.permlink,
      required this.comment,
      required this.weight});

  final String author;
  final String permlink;
  final String comment;
  final double weight;

  @override
  State<CommentDetailActionBar> createState() => _CommentDetailActionBarState();
}

class _CommentDetailActionBarState extends State<CommentDetailActionBar> {
  @override
  Widget build(BuildContext context) {
    return !context.isMobileSize ? _webActionBar() : _mobileActionBar();
  }

  Column _mobileActionBar() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyOutlinedButton(
                  onPressed: upvote,
                  icon: Icons.thumb_up_sharp,
                  text: "Upvote"),
            ),
            const Gap(15),
            Expanded(
              child: MyOutlinedButton(
                  onPressed: comment, icon: Icons.comment, text: "Reply"),
            ),
          ],
        ),
        const Gap(15),
        ColoredButton(text: "Upvote and Reply", onPressed: upvoteAndComment),
      ],
    );
  }

  Row _webActionBar() {
    return Row(
      children: [
        ColoredButton(text: "Reply", onPressed: comment),
        const Gap(10),
        ColoredButton(
            backgroundColor: Colors.blue, text: "Upvote", onPressed: upvote),
        const Spacer(),
        ColoredButton(text: "Upvote and Reply", onPressed: upvoteAndComment),
      ],
    );
  }

  void upvote() {
    final UserAuthModel userData = context.read<UserController>().userData!;
    if (widget.weight <= 0) {
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
    if (widget.comment.trim().isEmpty) {
      context.showSnackBar("Enter your comment");
    } else if (userData.isPostingKeyLogin) {
      _postingKeyCommentTransaction(userData, context);
    } else {
      _dialogForHiveTransaction(context, SignTransactionType.comment);
    }
  }

  void upvoteAndComment() {
    final UserAuthModel userData = context.read<UserController>().userData!;
    if (widget.comment.trim().isEmpty) {
      context.showSnackBar("Enter your comment");
    } else if (widget.weight <= 0) {
      context.showSnackBar("Please set your vote value higher than zero");
    } else if (userData.isPostingKeyLogin) {
      _postingKeyUpvoteCommentTransaction(userData, context);
    } else {
      _dialogForHiveTransaction(context, SignTransactionType.voteAndComment);
    }
  }

  void _postingKeyVoteTransaction(
      UserAuthModel userData, BuildContext context) async {
    context.showLoader();
    SignTransactionPostingKeyController().initVoteProcess(widget.weight * 100,
        author: widget.author,
        permlink: widget.permlink,
        authdata: userData as UserAuthModel<PostingAuthModel>,
        onSuccess: () {
          context.hideLoader();
          _addToProcessed();
        },
        onFailure: () => context.hideLoader(),
        showToast: (message) => context.showSnackBar(message));
  }

  void _postingKeyCommentTransaction(
      UserAuthModel<dynamic> userData, BuildContext context) async {
    context.showLoader();
    await SignTransactionPostingKeyController()
        .initCommentProcess(widget.comment.trim(),
            author: widget.author,
            parentPermlink: widget.permlink,
            authData: userData as UserAuthModel<PostingAuthModel>,
            onSuccess: (generatedPermlink) {
              context.hideLoader();
              _addToProcessed();
            },
            onFailure: () => context.hideLoader(),
            showToast: (message) => context.showSnackBar(message));
  }

  void _postingKeyUpvoteCommentTransaction(
      UserAuthModel<dynamic> userData, BuildContext context) async {
    context.showLoader();
    await SignTransactionPostingKeyController()
        .initVoteAndCommentProcess(widget.comment.trim(), widget.weight,
            author: widget.author,
            parentPermlink: widget.permlink,
            authdata: userData as UserAuthModel<PostingAuthModel>,
            onSuccess: () {
              context.hideLoader();
              _addToProcessed();
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
            author: widget.author,
            permlink: widget.permlink,
            weight: type == SignTransactionType.vote ||
                    type == SignTransactionType.voteAndComment
                ? widget.weight * 100
                : null,
            comment: type == SignTransactionType.comment ||
                    type == SignTransactionType.voteAndComment
                ? widget.comment.trim()
                : null,
            ishiveKeyChainMethod: authType == AuthType.hiveKeyChain);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HiveSignTransactionView(
        data: navigationData,
      );
    })).then((value) {
      if (value != null) {
        _addToProcessed();
      }
    });
  }

  void _addToProcessed() {
    // context
    //     .read<InboxController>()
    //     .addToProcessedComments(widget.author, widget.permlink);
    if (context.isMobileSize) {
      context.pop();
    }
  }
}
