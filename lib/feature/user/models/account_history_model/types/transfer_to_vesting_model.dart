import 'package:hive_mobile_app/core/utilities/save_convert.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class TransferToVestingModel implements AccountHistoryDataModel{
  final String amount;
  final String from;
  final String to;

  TransferToVestingModel({
    required this.amount,
    required this.from,
    required this.to,
  });

  factory TransferToVestingModel.fromJson(Map<String, dynamic> json) =>
      TransferToVestingModel(
        amount: asString(json, "amount"),
        from: asString(json, "from"),
        to: asString(json, "to"), 
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "from": from,
        "to": to,
      };
}
