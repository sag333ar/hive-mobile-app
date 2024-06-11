import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class TransferFromSavingsModel implements AccountHistoryDataModel{
  final String? from;
  final int? requestId;
  final String? to;
  final String? amount;
  final String? memo;

  TransferFromSavingsModel({
    this.from,
    this.requestId,
    this.to,
    this.amount,
    this.memo,
  });

  factory TransferFromSavingsModel.fromJson(Map<String, dynamic> json) =>
      TransferFromSavingsModel(
        from: json["from"],
        requestId: json["request_id"],
        to: json["to"],
        amount: json["amount"],
        memo: json["memo"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "request_id": requestId,
        "to": to,
        "amount": amount,
        "memo": memo,
      };
}
