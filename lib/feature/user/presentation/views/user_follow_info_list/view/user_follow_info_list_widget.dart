import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/scroll_end_listener.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/follow_info_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/controller/user_follow_info_list_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/widgets/uesr_follow_info_list_view/user_follow_info_list_view.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_follow_info_list/widgets/user_follow_info_list_grid_view/user_follow_info_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserFollowInfoListWidget extends StatelessWidget {
  const UserFollowInfoListWidget(
      {super.key,
      required this.type,
      required this.accountName,
      this.removeScaffold = false,
      this.screenWidth,
      required this.count});

  final FollowType type;
  final String accountName;
  final bool removeScaffold;
  final int count;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) =>
          UserFollowInfoListController(type: type, accountName: accountName),
      builder: (context, child) {
        final controller = context.read<UserFollowInfoListController>();
        return !removeScaffold
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    type == FollowType.followers
                        ? "Followers ($count)"
                        : "Following ($count)",
                    style: theme.textTheme.displayMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                body: _body(controller),
              )
            : _body(controller);
      },
    );
  }

  Selector<UserFollowInfoListController, ViewState> _body(
      UserFollowInfoListController controller) {
    return Selector<UserFollowInfoListController, ViewState>(
      selector: (_, provider) => provider.viewState,
      builder: (context, value, child) {
        if (value == ViewState.data) {
          return _dataState(controller);
        } else if (value == ViewState.empty) {
          return Emptystate(
              text: type == FollowType.followers
                  ? 'No Followers found'
                  : "You are not following anyone");
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
  }

  Widget _dataState(UserFollowInfoListController controller) {
    return Selector<UserFollowInfoListController, List<FollowInfoModel>>(
      shouldRebuild: (previous, next) =>
          previous != next || previous.length != next.length,
      selector: (_, provider) => provider.items,
      builder: (context, items, child) {
        return ScrollEndListener(
          loadNextPage: () => controller.loadNextPage(),
          child: ScreenTypeLayout.builder(
            mobile: (_) => UserFollowInfoListView(
              items: items,
              type: type,
            ),
            tablet: (_) => UserFollowInfoListGridView(
              items: items,
              type: type,
              screenWidth: screenWidth,
            ),
            desktop: (_) => UserFollowInfoListGridView(
                items: items, type: type, screenWidth: screenWidth),
          ),
        );
      },
    );
  }
}
