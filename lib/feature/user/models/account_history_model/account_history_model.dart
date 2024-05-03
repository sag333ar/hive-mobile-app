import 'dart:convert';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/cancel_transfer_from_savings_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/claim_reward_balance_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/interest_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/producer_reward_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/tranfer_from_savings_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/transfer_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/transfer_to_savings_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/transfer_to_vesting_model.dart';
import 'package:hive_mobile_app/feature/user/models/account_history_model/types/with_draw_vesting.model.dart';

class AccountHistoryModel {
  final AccountHistoryDataModel op;
  final int id;
  final int? block;
  final String? trxId;
  final int? opInTrx;
  final DateTime? timestamp;
  final bool? virtualOp;
  final int? trxInBlock;
  final AccountHistoryType type;

  AccountHistoryModel(
      {required this.op,
      this.block,
      this.trxId,
      this.opInTrx,
      this.timestamp,
      this.virtualOp,
      this.trxInBlock,
      required this.id,
      required this.type});

  factory AccountHistoryModel.fromRawJson(String str) =>
      AccountHistoryModel.fromJson(json.decode(str));

  factory AccountHistoryModel.fromJson(List data) {
    Map<String, dynamic> json = data[1];
    return AccountHistoryModel(
      op: _parseOpData(json),
      id: data[0],
      block: json["block"],
      trxId: json["trx_id"],
      opInTrx: json["op_in_trx"],
      type: enumFromString(_parseOpType(json), AccountHistoryType.values),
      timestamp:
          json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
      virtualOp: json["virtual_op"],
      trxInBlock: json["trx_in_block"],
    );
  }

  static _parseOpType(Map<String, dynamic> json) {
    List op = json["op"] as List;
    return op.first;
  }

  static AccountHistoryDataModel _parseOpData(Map<String, dynamic> json) {
    List op = json["op"] as List;
    Map<String, dynamic> data = op[1];
    AccountHistoryType type =
        enumFromString(_parseOpType(json), AccountHistoryType.values);
    switch (type) {
      case AccountHistoryType.claim_reward_balance:
        return ClaimRewardBalanceModel.fromJson(data);
      case AccountHistoryType.cancel_transfer_from_savings:
        return CancelTransferFromSavingsModel.fromJson(data);
      case AccountHistoryType.withdraw_vesting:
        return WithDrawVestingModel.fromJson(data);
      case AccountHistoryType.transfer_to_vesting:
        return TransferToVestingModel.fromJson(data);
      case AccountHistoryType.transfer_to_savings:
        return TransferToSavingsModel.fromJson(data);
      case AccountHistoryType.transfer_from_savings:
        return TransferFromSavingsModel.fromJson(data);
      case AccountHistoryType.transfer:
        return TransferModel.fromJson(data);
      case AccountHistoryType.producer_reward:
        return ProducerRewardModel.fromJson(data);
      case AccountHistoryType.interest:
        return InterestModel.fromJson(data);
    }
  }
}
