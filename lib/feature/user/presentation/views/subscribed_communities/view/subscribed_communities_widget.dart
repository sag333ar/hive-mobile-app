import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/subscribed_communities/subscribed_community_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/controller/subscribed_communities_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/widgets/subscribed_communities_grid_view/subscribed_communities_grid_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/subscribed_communities/widgets/subscribed_communities_list_view/subscribed_communities_list_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';
import 'package:provider/provider.dart';

class SubscribedCommunitiesWidget extends StatelessWidget {
  const SubscribedCommunitiesWidget(
      {super.key, this.screenWidth, this.controller});

  final double? screenWidth;
  final SubscribedCommunitiesController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: controller,
      child: _initalBody(controller!, theme),
    );
  }

  Widget _initalBody(
      SubscribedCommunitiesController controller, final ThemeData theme) {
    return _body(controller, theme);
  }

  Selector<SubscribedCommunitiesController, ViewState> _body(
      SubscribedCommunitiesController controller, ThemeData theme) {
    return Selector<SubscribedCommunitiesController, ViewState>(
      selector: (_, provider) => provider.viewState,
      builder: (context, value, child) {
        if (value == ViewState.data) {
          return _dataState(controller, theme);
        } else if (value == ViewState.empty) {
          return const Emptystate(
            text: "No Subscribers Found",
            isSliver: true,
          );
        } else if (value == ViewState.error) {
          return ErrorState(
            isSliver: true,
            showRetryButton: true,
            onTapRetryButton: () => controller.refresh(),
          );
        } else {
          return const LoadingState(
            isSliver: true,
          );
        }
      },
    );
  }

  Widget _dataState(
      SubscribedCommunitiesController controller, ThemeData theme) {
    return Selector<SubscribedCommunitiesController,
            List<SubscribedCommunityModel>>(
        shouldRebuild: (previous, next) =>
            previous != next || previous.length != next.length,
        selector: (_, provider) => provider.items,
        builder: (context, items, child) {
          return layoutChild(context, items, theme);
        });
  }

  Widget layoutChild(BuildContext context, List<SubscribedCommunityModel> items,
      ThemeData theme) {
    if (context.isMobileSize) {
      return SubscribedCommunitiesListView(
        items: items,
      );
    } else if (context.isTabletSize) {
      return SubscribedCommunitiesGridView(
        items: items,
        screenWidth: screenWidth,
        decrementWidth: ProfileMenuTemplate.width,
      );
    } else {
      return SubscribedCommunitiesGridView(
        items: items,
        screenWidth: screenWidth,
        decrementWidth: ProfileMenuTemplate.width,
      );
    }
  }
}
