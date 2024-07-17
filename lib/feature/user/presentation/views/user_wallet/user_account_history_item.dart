import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/utilities/constants/constants.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/governance/presentation/views/proposals/widgets/sender_to_receiver.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/cancel_transfer_from_savings_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/claim_reward_balance_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/transfer_to_vesting_model.dart';
import 'package:hive_mobile_app/feature/user/models/global_props_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserAccountHistoryItem extends StatelessWidget {
  const UserAccountHistoryItem(
      {super.key, required this.item, required this.props});

  final AccountHistoryModel item;
  final GlobalChainPropsModel? props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _item(theme);
  }

  Widget _item(ThemeData theme) {
    switch (item.type) {
      case AccountHistoryType.claim_reward_balance:
        return _claimRewardBalance(theme);
      case AccountHistoryType.cancel_transfer_from_savings:
        return _cancelTransferFromSavings();
      case AccountHistoryType.withdraw_vesting:
        return _withdrawVesting();
      case AccountHistoryType.transfer_to_vesting:
        return _transferToVesting(theme);
      case AccountHistoryType.transfer_to_savings:
        return _transferToSavings();
      case AccountHistoryType.transfer_from_savings:
        return _transferFromSavings();
      case AccountHistoryType.transfer:
        return _transfer();
      case AccountHistoryType.producer_reward:
        return _producerReward();
      case AccountHistoryType.interest:
        return _interest();
    }
  }

  Widget _claimRewardBalance(ThemeData theme) {
    ClaimRewardBalanceModel item = this.item.op as ClaimRewardBalanceModel;
    return ListTile(
        tileColor: theme.colorScheme.onTertiaryContainer,
        leading: const Icon(Icons.abc),
        title: const Text("Claim Rewards"),
        subtitle: Text(timeago.format(this.item.timestamp!),
            style: _subTitleStyle(theme)),
        trailing: Column(
          children: [
            props != null
                ? Text(
                    vestingToHivePower(props!, item.rewardVests),
                    style: _trailingTextStyle(theme),
                  )
                : const SizedBox.shrink(),
            if (item.rewardHbd != null &&
                removeHbdFromString(item.rewardHbd!) != 0)
              Text(
                item.rewardHbd!,
                style: _trailingTextStyle(theme),
              )
          ],
        ));
  }

  Widget _cancelTransferFromSavings() {
    CancelTransferFromSavingsModel item =
        this.item.op as CancelTransferFromSavingsModel;
    return const SizedBox();
  }

  Widget _withdrawVesting() {
    return const SizedBox();
  }

  Widget _transferToVesting(ThemeData theme) {
    TransferToVestingModel item = this.item.op as TransferToVestingModel;
    return Container(
      color: theme.colorScheme.onTertiaryContainer,
      padding: const EdgeInsets.symmetric(
          horizontal: kScreenHorizontalPaddingDigit, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.zoom_out_rounded),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("Delegation")),
                    const Gap(15),
                    Text(
                      item.amount,
                      style: _trailingTextStyle(theme),
                    )
                  ],
                ),
                const Gap(2),
                Text(timeago.format(this.item.timestamp!),
                    style: _subTitleStyle(theme)),
                SenderToReceiver(
                  textStyle: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w300),
                  from: item.from,
                  to: item.to,
                  imageRadius: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _transferToSavings() {
    return const SizedBox();
  }

  Widget _transferFromSavings() {
    return const SizedBox();
  }

  Widget _transfer() {
    return const SizedBox();
  }

  Widget _producerReward() {
    return const SizedBox();
  }

  Widget _interest() {
    return const SizedBox();
  }

  TextStyle _subTitleStyle(ThemeData theme) {
    return theme.textTheme.labelMedium!
        .copyWith(color: theme.primaryColorDark.withOpacity(0.5));
  }

  TextStyle _trailingTextStyle(ThemeData theme) {
    return theme.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.secondaryContainer);
  }

  double removeHbdFromString(String rewardHbd) {
    String string = rewardHbd.split(" ")[0];
    return double.parse(string);
  }

  String vestingToHivePower(GlobalChainPropsModel props, String? vesting) {
    try {
      double hive = (double.parse(props.totalVestingFundHive!.split(" ")[0]) *
              double.parse(vesting!.split(" ")[0])) /
          double.parse(props.totalVestingShares!.split(" ")[0]);
      return "${hive.toStringAsFixed(3)} HP";
    } catch (e) {
      return "0.0 HP";
    }
  }
}
