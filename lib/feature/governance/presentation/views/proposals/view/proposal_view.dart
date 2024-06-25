import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/proposal_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/controller/proposal_controller.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/widgets/proposal_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProposalView extends StatelessWidget {
  const ProposalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proposals"),
        leading: BackButton(
          onPressed: () => context.platformPop(name: Routes.initialView),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.isMobile ? EdgeInsets.zero : kScreenPadding,
          child: ChangeNotifierProvider(
            create: (context) => ProposalController(),
            builder: (context, child) {
              final controller = context.read<ProposalController>();
              return Selector<ProposalController, ViewState>(
                selector: (_, provider) => provider.viewState,
                builder: (context, value, child) {
                  if (value == ViewState.data) {
                    return _dataState(controller);
                  } else if (value == ViewState.empty) {
                    return const Emptystate(
                        icon: Icons.hourglass_empty,
                        text: 'No Proposals found');
                  } else if (value == ViewState.error) {
                    return ErrorState(
                      showRetryButton: true,
                      onTapRetryButton: () => controller.refresh(),
                    );
                  } else {
                    return const LoadingState();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _dataState(ProposalController controller) {
    return Selector<ProposalController, List<ProposalModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return ScrollEndListener(
          loadNextPage: () => controller.loadNextPage(),
          child: ScreenTypeLayout.builder(
            mobile: (_) => ProposalWidget(items: items),
            tablet: (_) => ProposalWidget(items: items),
            desktop: (_) => ProposalWidget(
              items: items,
            ),
          ),
        );
      },
    );
  }
}
