import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class TransferToSavingsModel implements AccountHistoryDataModel {
  final String? from;
  final String? to;
  final String? amount;
  final String? memo;

  TransferToSavingsModel({
    this.from,
    this.to,
    this.amount,
    this.memo,
  });

  factory TransferToSavingsModel.fromJson(Map<String, dynamic> json) =>
      TransferToSavingsModel(
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        memo: json["memo"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "amount": amount,
        "memo": memo,
      };
}
