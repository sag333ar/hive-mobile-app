import 'package:equatable/equatable.dart';
import 'package:hive_mobile_app/core/utilities/save_convert.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/hbd_exchange_rate_model.dart';
import 'package:hive_mobile_app/feature/governance/models/witnesses/props_model.dart';

class WitnessesModel extends Equatable {
  final int? availableWitnessAccountSubsidies;
  final DateTime created;
  final DateTime? hardforkTimeVote;
  final String? hardforkVersionVote;
  final HbdExchangeRateModel? hbdExchangeRate;
  final int id;
  final int? lastAslot;
  final int? lastConfirmedBlockNum;
  final DateTime? lastHbdExchangeUpdate;
  final String? lastWork;
  final String owner;
  final int? powWorker;
  final PropsModel? blockProps;
  final String? runningVersion;
  final String? signingKey;
  final int? totalMissed;
  final String url;
  final String? virtualLastUpdate;
  final String? virtualPosition;
  final String? virtualScheduledTime;
  final String? votes;

  const WitnessesModel({
    this.availableWitnessAccountSubsidies,
    required this.created,
    this.hardforkTimeVote,
    this.hardforkVersionVote,
    this.hbdExchangeRate,
    required this.id,
    this.lastAslot,
    this.lastConfirmedBlockNum,
    this.lastHbdExchangeUpdate,
    this.lastWork,
    required this.owner,
    this.powWorker,
    this.blockProps,
    this.runningVersion,
    this.signingKey,
    this.totalMissed,
    required this.url,
    this.virtualLastUpdate,
    this.virtualPosition,
    this.virtualScheduledTime,
    this.votes,
  });

  WitnessesModel copyWith({
    int? availableWitnessAccountSubsidies,
    DateTime? created,
    DateTime? hardforkTimeVote,
    String? hardforkVersionVote,
    HbdExchangeRateModel? hbdExchangeRate,
    int? id,
    int? lastAslot,
    int? lastConfirmedBlockNum,
    DateTime? lastHbdExchangeUpdate,
    String? lastWork,
    String? owner,
    int? powWorker,
    PropsModel? props,
    String? runningVersion,
    String? signingKey,
    int? totalMissed,
    String? url,
    String? virtualLastUpdate,
    String? virtualPosition,
    String? virtualScheduledTime,
    String? votes,
  }) =>
      WitnessesModel(
        availableWitnessAccountSubsidies: availableWitnessAccountSubsidies ??
            this.availableWitnessAccountSubsidies,
        created: created ?? this.created,
        hardforkTimeVote: hardforkTimeVote ?? this.hardforkTimeVote,
        hardforkVersionVote: hardforkVersionVote ?? this.hardforkVersionVote,
        hbdExchangeRate: hbdExchangeRate ?? this.hbdExchangeRate,
        id: id ?? this.id,
        lastAslot: lastAslot ?? this.lastAslot,
        lastConfirmedBlockNum:
            lastConfirmedBlockNum ?? this.lastConfirmedBlockNum,
        lastHbdExchangeUpdate:
            lastHbdExchangeUpdate ?? this.lastHbdExchangeUpdate,
        lastWork: lastWork ?? this.lastWork,
        owner: owner ?? this.owner,
        powWorker: powWorker ?? this.powWorker,
        blockProps: props ?? blockProps,
        runningVersion: runningVersion ?? this.runningVersion,
        signingKey: signingKey ?? this.signingKey,
        totalMissed: totalMissed ?? this.totalMissed,
        url: url ?? this.url,
        virtualLastUpdate: virtualLastUpdate ?? this.virtualLastUpdate,
        virtualPosition: virtualPosition ?? this.virtualPosition,
        virtualScheduledTime: virtualScheduledTime ?? this.virtualScheduledTime,
        votes: votes ?? this.votes,
      );

  factory WitnessesModel.fromJson(Map<String, dynamic> json) => WitnessesModel(
        availableWitnessAccountSubsidies:
            json["available_witness_account_subsidies"],
        created: DateTime.parse(json["created"]),
        hardforkTimeVote: json["hardfork_time_vote"] == null
            ? null
            : DateTime.parse(json["hardfork_time_vote"]),
        hardforkVersionVote: json["hardfork_version_vote"],
        hbdExchangeRate: json["hbd_exchange_rate"] == null
            ? null
            : HbdExchangeRateModel.fromJson(json["hbd_exchange_rate"]),
        id: json["id"] ?? "",
        lastAslot: json["last_aslot"],
        lastConfirmedBlockNum: json["last_confirmed_block_num"],
        lastHbdExchangeUpdate: json["last_hbd_exchange_update"] == null
            ? null
            : DateTime.parse(json["last_hbd_exchange_update"]),
        lastWork: json["last_work"],
        owner: json["owner"] ?? "",
        powWorker: json["pow_worker"],
        blockProps:
            json["props"] == null ? null : PropsModel.fromJson(json["props"]),
        runningVersion: json["running_version"],
        signingKey: json["signing_key"],
        totalMissed: json["total_missed"],
        url: json["url"] ?? "",
        virtualLastUpdate: json["virtual_last_update"],
        virtualPosition: json["virtual_position"],
        virtualScheduledTime: json["virtual_scheduled_time"],
        votes: asString(json, "votes"),
      );

  Map<String, dynamic> toJson() => {
        "available_witness_account_subsidies": availableWitnessAccountSubsidies,
        "created": created.toIso8601String(),
        "hardfork_time_vote": hardforkTimeVote?.toIso8601String(),
        "hardfork_version_vote": hardforkVersionVote,
        "hbd_exchange_rate": hbdExchangeRate?.toJson(),
        "id": id,
        "last_aslot": lastAslot,
        "last_confirmed_block_num": lastConfirmedBlockNum,
        "last_hbd_exchange_update": lastHbdExchangeUpdate?.toIso8601String(),
        "last_work": lastWork,
        "owner": owner,
        "pow_worker": powWorker,
        "props": blockProps?.toJson(),
        "running_version": runningVersion,
        "signing_key": signingKey,
        "total_missed": totalMissed,
        "url": url,
        "virtual_last_update": virtualLastUpdate,
        "virtual_position": virtualPosition,
        "virtual_scheduled_time": virtualScheduledTime,
        "votes": votes,
      };
      
        @override
        List<Object?> get props => [owner,id];
}
