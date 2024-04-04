import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/models/community/community_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/controller/community_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/widgets/community_grid_view.dart/community_grid_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/views/community_list/widgets/community_list_view/community_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CommunityListWidgetView extends StatefulWidget {
  const CommunityListWidgetView({super.key});

  @override
  State<CommunityListWidgetView> createState() =>
      _CommunityListWidgetViewState();
}

class _CommunityListWidgetViewState extends State<CommunityListWidgetView>
    with AutomaticKeepAliveClientMixin {
  CommunityListController controller = CommunityListController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        return Selector<CommunityListController, ViewState>(
          selector: (_, provider) => provider.viewState,
          builder: (context, value, child) {
            if (value == ViewState.data) {
              return _dataState();
            } else if (value == ViewState.empty) {
              return const Emptystate(text: 'No Communities found');
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
    );
  }

  Widget _dataState() {
    return Selector<CommunityListController, List<CommunityModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return ScrollEndListener(
          loadNextPage: () => controller.loadNextPage(),
          child: ScreenTypeLayout.builder(
            mobile: (_) => CommunityListView(
              items: items,
            ),
            tablet: (_) => CommunityGridView(
              items: items,
            ),
            desktop: (_) => CommunityGridView(
              items: items,
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
