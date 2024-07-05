import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/inbox_list_view.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/web_inbox_widget_view.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  final ValueNotifier<PostFeedModel?>? selectedPostDetailView =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final String currentUserName = context.read<UserController>().userName!;
    return ChangeNotifierProvider(
      create: (context) => InboxController(
        accountName: currentUserName,
      ),
      builder: (context, child) {
        final controller = context.read<InboxController>();
        return Scaffold(
            appBar: AppBar(
              title: const Text("Inbox"),
            ),
            body: Selector<InboxController, ViewState>(
              selector: (_, myType) => myType.viewState,
              builder: (context, state, child) {
                if (state == ViewState.data) {
                  return _data();
                } else if (state == ViewState.empty) {
                  return const Emptystate(text: "No Replies found");
                } else if (state == ViewState.error) {
                  return ErrorState(
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

  Widget _data() {
    return ScreenTypeLayout.builder(
        mobile: (_) => const InboxListView(
              showMasterView: false,
            ),
        tablet: (_) => _tabletAndWebView(),
        desktop: (_) => _tabletAndWebView());
  }

  Widget _tabletAndWebView() {
    return WebInboxWidgetView(selectedPostDetailView: selectedPostDetailView!);
  }
}
