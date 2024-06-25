import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class WithDrawVestingModel implements AccountHistoryDataModel {
  final String? account;
  final String? vestingShares;

  WithDrawVestingModel({
    this.account,
    this.vestingShares,
  });

  factory WithDrawVestingModel.fromJson(Map<String, dynamic> json) =>
      WithDrawVestingModel(
        account: json["account"],
        vestingShares: json["vesting_shares"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "vesting_shares": vestingShares,
      };
}
