import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/community/models/community_detail/community_team_model.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/controller/community_subscribers_controller.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/widgets/community_subscribers_grid_view/community_subscribers_grid_view.dart';
import 'package:hive_mobile_app/feature/community/presentation/community_profile/view/community_subscribers/widgets/community_subscribers_list_view/community_subscribers_list_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/profile_menu_template.dart';
import 'package:provider/provider.dart';

class CommunitySubscribersListWidget extends StatelessWidget {
  const CommunitySubscribersListWidget(
      {super.key,
      required this.communityId,
      this.removeScaffold = false,
      this.screenWidth,
      this.count,
      this.controller});

  final String communityId;
  final bool removeScaffold;
  final int? count;
  final double? screenWidth;
  final CommunitySubscribersListController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return controller == null
        ? ChangeNotifierProvider(
            create: (context) => CommunitySubscribersListController(
              communityId: communityId,
            ),
            builder: (context, child) {
              final controller =
                  context.read<CommunitySubscribersListController>();
              return _initalBody(controller, theme);
            },
          )
        : ChangeNotifierProvider.value(
            value: controller,
            child: _initalBody(controller!, theme),
          );
  }

  Widget _initalBody(
      CommunitySubscribersListController controller, final ThemeData theme) {
    return !removeScaffold
        ? Scaffold(
            appBar: count != null
                ? AppBar(
                    title: Text(
                      "Subscribers ($count)",
                      style: theme.textTheme.displayMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : null,
            body: _body(controller, theme),
          )
        : _body(controller, theme);
  }

  Selector<CommunitySubscribersListController, ViewState> _body(
      CommunitySubscribersListController controller, ThemeData theme) {
    return Selector<CommunitySubscribersListController, ViewState>(
      selector: (_, provider) => provider.viewState,
      builder: (context, value, child) {
        if (value == ViewState.data) {
          return _dataState(controller, theme);
        } else if (value == ViewState.empty) {
          return Emptystate(
            text: "No Subscribers Found",
            isSliver: this.controller != null,
          );
        } else if (value == ViewState.error) {
          return ErrorState(
            isSliver: this.controller != null,
            showRetryButton: true,
            onTapRetryButton: () => controller.refresh(),
          );
        } else {
          return LoadingState(
            isSliver: this.controller != null,
          );
        }
      },
    );
  }

  Widget _dataState(
      CommunitySubscribersListController controller, ThemeData theme) {
    return Selector<CommunitySubscribersListController,
        List<CommunityMemberModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return this.controller != null
            ? layoutChild(context, items, theme)
            : ScrollEndListener(
                loadNextPage: () => controller.loadNextPage(),
                child: layoutChild(context, items, theme));
      },
    );
  }

  Widget layoutChild(
      BuildContext context, List<CommunityMemberModel> items, ThemeData theme) {
    bool isNestedRoute = controller != null;
    if (context.isMobileSize) {
      return CommunitySubscribersListView(
        isSliver: isNestedRoute,
        items: items,
        popOnTap: !isNestedRoute,
      );
    } else if (context.isTabletSize) {
      return CommunitySubscribersGridView(
        itemColor: isNestedRoute ? theme.colorScheme.onTertiaryContainer : null,
        isSliver: isNestedRoute,
        items: items,
        screenWidth: screenWidth,
        decrementWidth: isNestedRoute ? ProfileMenuTemplate.width : null,
         popOnTap: !isNestedRoute,
      );
    } else {
      return CommunitySubscribersGridView(
        itemColor: isNestedRoute ? theme.colorScheme.onTertiaryContainer : null,
        isSliver: isNestedRoute,
        items: items,
        screenWidth: screenWidth,
        decrementWidth: isNestedRoute ? ProfileMenuTemplate.width : null,
         popOnTap: !isNestedRoute,
      );
    }
  }
}
