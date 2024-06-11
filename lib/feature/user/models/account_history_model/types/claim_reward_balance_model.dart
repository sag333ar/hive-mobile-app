import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class ClaimRewardBalanceModel implements AccountHistoryDataModel{
  final String? account;
  final String? rewardHbd;
  final String? rewardHive;
  final String? rewardVests;

  ClaimRewardBalanceModel({
    this.account,
    this.rewardHbd,
    this.rewardHive,
    this.rewardVests,
  });

  factory ClaimRewardBalanceModel.fromJson(Map<String, dynamic> json) =>
      ClaimRewardBalanceModel(
        account: json["account"],
        rewardHbd: json["reward_hbd"],
        rewardHive: json["reward_hive"],
        rewardVests: json["reward_vests"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "reward_hbd": rewardHbd,
        "reward_hive": rewardHive,
        "reward_vests": rewardVests,
      };
}
