import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/witnesses_model.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/controller/witnesses_controller.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/mobile_view/witness_mobile_widget.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/tablet_view/witness_tablet_widget.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/witnesses/widgets/webview/witness_web_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WitnessesView extends StatelessWidget {
  const WitnessesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.isMobile ? const Text("Witnesses") : null,
        leading: BackButton(
          onPressed: () => context.platformPop(name: Routes.initialView),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.isMobile ? EdgeInsets.zero : kScreenPadding,
          child: ChangeNotifierProvider(
            create: (context) => WitnessController(),
            builder: (context, child) {
              final controller = context.read<WitnessController>();
              return Selector<WitnessController, ViewState>(
                selector: (_, provider) => provider.viewState,
                builder: (context, value, child) {
                  if (value == ViewState.data) {
                    return _dataState(controller);
                  } else if (value == ViewState.empty) {
                    return const Emptystate(
                        icon: Icons.hourglass_empty,
                        text: 'No Witnesses found');
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

  Widget _dataState(WitnessController controller) {
    return Selector<WitnessController, List<WitnessesModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return ScrollEndListener(
          loadNextPage: () => controller.loadNextPage(),
          child: ScreenTypeLayout.builder(
            mobile: (_) => WitnessMobileWidget(items: items),
            tablet: (_) => WitnessTabletWidget(items: items),
            desktop: (_) => WitnessWebWidget(
              items: items,
            ),
          ),
        );
      },
    );
  }
}
