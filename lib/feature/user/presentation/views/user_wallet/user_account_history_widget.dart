import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/widgets/empty_state.dart';
import 'package:hive_mobile_app/core/common/widgets/loading_state.dart';
import 'package:hive_mobile_app/core/common/widgets/server_error.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_model.dart';
import 'package:hive_mobile_app/feature/user/models/global_props_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_account_history/user_account_history_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_wallet/user_account_history_item.dart';
import 'package:provider/provider.dart';

class UserAccountHistoryWidget extends StatelessWidget {
  const UserAccountHistoryWidget({super.key, required this.controller});

  final UserAccountHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, child) {
        return Selector<UserAccountHistoryController, ViewState>(
          selector: (_, provider) => provider.viewState,
          builder: (context, state, child) {
            if (state == ViewState.data) {
              return _dataState(
                controller,
              );
            } else if (state == ViewState.empty) {
              return const Emptystate(
                text: "User account history is empty",
                isSliver: true,
              );
            } else if (state == ViewState.error) {
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
      },
    );
  }

  Widget _dataState(
    UserAccountHistoryController controller,
  ) {
    return Selector<UserAccountHistoryController, List<AccountHistoryModel>>(
        shouldRebuild: (previous, next) =>
            previous != next || previous.length != next.length,
        selector: (_, provider) => provider.items,
        builder: (context, items, child) {
          return layoutChild(
            context,
            items,
          );
        });
  }

  Widget layoutChild(
    BuildContext context,
    List<AccountHistoryModel> items,
  ) {
    return Selector<UserProfileController, GlobalChainPropsModel?>(
      selector: (_, provider) => provider.props,
      builder: (context, value, child) {
        return SliverList.separated(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            AccountHistoryModel item = items[index];
            return UserAccountHistoryItem(
              item: item,
              props: value,
            );
          },
          separatorBuilder: (context, index) => const Gap(2),
        );
      },
    );
  }
}
