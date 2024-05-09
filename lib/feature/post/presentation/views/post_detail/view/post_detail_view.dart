import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/controller/post_detail_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/widgets/post_detail_web_view/post_detail_max_web_view.dart';
import 'package:provider/provider.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView(
      {super.key, required this.author, required this.permlink});

  final String author;
  final String permlink;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostDetailController(
        accountName: author,
        permlink: permlink,
      ),
      builder: (context, child) {
        final controller = context.read<PostDetailController>();
        return Scaffold(
            body: Selector<PostDetailController, ViewState>(
              selector: (_, provider) => provider.viewState,
              builder: (context, value, child) {
                if (value == ViewState.data) {
                  return const PostDetailMaxWebView();
                } else if (value == ViewState.empty) {
                  return const Emptystate(
                      icon: Icons.hourglass_empty, text: 'No feeds found');
                } else if (value == ViewState.error) {
                  return ErrorState(
                    showRetryButton: true,
                    onTapRetryButton: () => controller.refresh(),
                  );
                } else {
                  return const LoadingState();
                }
              },
            ));
      },
    );
  }
}
