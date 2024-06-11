import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class TransferModel implements AccountHistoryDataModel{
  final String? amount;
  final String? from;
  final String? memo;
  final String? to;

  TransferModel({
    this.amount,
    this.from,
    this.memo,
    this.to,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        amount: json["amount"],
        from: json["from"],
        memo: json["memo"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "from": from,
        "memo": memo,
        "to": to,
      };
}
