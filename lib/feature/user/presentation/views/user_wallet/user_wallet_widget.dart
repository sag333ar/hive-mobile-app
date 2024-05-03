import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/user/models/global_props_model.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/controllers/user_profile_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_account_history/user_account_history_controller.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_wallet/user_account_history_widget.dart';
import 'package:hive_mobile_app/feature/user/presentation/views/user_wallet/wallet_tile.dart';
import 'package:provider/provider.dart';

class UserWalletWidget extends StatelessWidget {
  const UserWalletWidget({super.key, this.data, required this.controller});

  final UserModel? data;
  final UserAccountHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: kScreenPadding,
            child: Column(children: children(context)),
          ),
        ),
        SliverCrossAxisGroup(slivers: [
          UserAccountHistoryWidget(controller: controller),
          if (context.isDesktopSize)
            const SliverConstrainedCrossAxis(
              maxExtent: 300,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: 300,
                ),
              ),
            )
        ])
      ],
    );
  }

  List<Widget> children(BuildContext context) {
    return [
      _hive(),
      _hivePower(),
      const Gap(15),
      _hiveDollars(),
      const Gap(15),
      _savings(),
      const Gap(15),
      _estimatedWalletValue(),
    ];
  }

  WalletTile _estimatedWalletValue() {
    return const WalletTile(
      title: "ESTIMATED WALLET VALUE",
      content: "The estimated value is based on a 7 day average value of HIVE.",
      value: "\$ 0.213",
    );
  }

  WalletTile _savings() {
    return const WalletTile(
      title: "SAVINGS",
      content: "Balance subject to 3 day withdraw waiting period.",
      subContent: "APR interest rate for HBD(\$) is 20%",
      value: "4567 hive",
    );
  }

  Widget _hivePower() {
    return Selector<UserProfileController, GlobalChainPropsModel?>(
      selector: (_, provider) => provider.props,
      builder: (context, value, child) {
        if (value != null) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: WalletTile(
              isExpand: true,
              title: "HIVE POWER",
              subTitle:
                  "${vestingToHivePower(value, data!.vestingShares).toStringAsFixed(3)} HP",
              content:
                  "Hive Power are influence tokens that earn more power for holding long term and voting on content. The more Hive Power one holds, the more one can influence other’s rewards and earn rewards for accurate voting. Hive Power is staked HIVE token that can be unstaked in 13 weeks.",
              value: "${_hivePowerValue(value)} HP",
              subContent: "APR interest rate for Hive Power is 2.928%",
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  WalletTile _hiveDollars() {
    return WalletTile(
      title: "HIVE DOLLARS",
      content: "Tokens worth about \$1.00 of HIVE.",
      value: data!.hbdBalance,
    );
  }

  WalletTile _hive() {
    return WalletTile(
      title: "HIVE",
      content:
          "HIVE are tradeable tokens that may be transferred at anytime.HIVE can be converted to Hive Power in a process called powering up.",
      value: data!.balance,
    );
  }

  double vestingToHivePower(GlobalChainPropsModel props, String? vesting) {
    try {
      double hive = (double.parse(props.totalVestingFundHive!.split(" ")[0]) *
              double.parse(vesting!.split(" ")[0])) /
          double.parse(props.totalVestingShares!.split(" ")[0]);
      return hive;
    } catch (e) {
      return 0.0;
    }
  }

  String _hivePowerValue(
    GlobalChainPropsModel props,
  ) {
    var delegated = vestingToHivePower(props, data!.delegatedVestingShares);
    var received = vestingToHivePower(props, data!.receivedVestingShares);
    var vesting = vestingToHivePower(props, data!.vestingShares);
    var result = (vesting + received) - delegated;
    return result.toStringAsFixed(3);
  }
}
