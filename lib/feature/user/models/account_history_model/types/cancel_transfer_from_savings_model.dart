import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class CancelTransferFromSavingsModel implements AccountHistoryDataModel {
  final String? from;
  final int? requestId;

  CancelTransferFromSavingsModel({
    this.from,
    this.requestId,
  });

  factory CancelTransferFromSavingsModel.fromJson(Map<String, dynamic> json) =>
      CancelTransferFromSavingsModel(
        from: json["from"],
        requestId: json["request_id"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "request_id": requestId,
      };
}
