import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class InterestModel implements AccountHistoryDataModel{
  final String? owner;
  final String? interest;
  final bool? isSavedIntoHbdBalance;

  InterestModel({
    this.owner,
    this.interest,
    this.isSavedIntoHbdBalance,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) => InterestModel(
        owner: json["owner"],
        interest: json["interest"],
        isSavedIntoHbdBalance: json["is_saved_into_hbd_balance"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "interest": interest,
        "is_saved_into_hbd_balance": isSavedIntoHbdBalance,
      };
}
