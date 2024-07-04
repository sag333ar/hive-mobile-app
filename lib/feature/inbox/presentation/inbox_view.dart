import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/controller/inbox_controller.dart';
import 'package:provider/provider.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

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
    return const SizedBox();
  }
}
