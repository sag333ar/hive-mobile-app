import 'dart:convert';

import 'package:equatable/equatable.dart';

class GlobalChainPropsModel extends Equatable {
  final int? availableAccountSubsidies;
  final int? contentRewardPercent;
  final int? currentAslot;
  final String? currentHbdSupply;
  final int? currentRemoveThreshold;
  final String? currentSupply;
  final String? currentWitness;
  final int? delegationReturnPeriod;
  final String? dhfIntervalLedger;
  final int? downvotePoolPercent;
  final int? earlyVotingSeconds;
  final int? hbdInterestRate;
  final int? hbdPrintRate;
  final int? hbdStartPercent;
  final int? hbdStopPercent;
  final String? headBlockId;
  final int? headBlockNumber;
  final String? initHbdSupply;
  final DateTime? lastBudgetTime;
  final int? lastIrreversibleBlockNum;
  final int? maxConsecutiveRecurrentTransferFailures;
  final int? maxOpenRecurrentTransfers;
  final int? maxRecurrentTransferEndDate;
  final int? maximumBlockSize;
  final int? midVotingSeconds;
  final int? minRecurrentTransfersRecurrence;
  final DateTime? nextDailyMaintenanceTime;
  final DateTime? nextMaintenanceTime;
  final int? numPowWitnesses;
  final int? participationCount;
  final String? pendingRewardedVestingHive;
  final String? pendingRewardedVestingShares;
  final int? proposalFundPercent;
  final String? recentSlotsFilled;
  final int? reverseAuctionSeconds;
  final DateTime? time;
  final int? totalPow;
  final String? totalRewardFundHive;
  final String? totalRewardShares2;
  final String? totalVestingFundHive;
  final String? totalVestingShares;
  final int? vestingRewardPercent;
  final String? virtualSupply;
  final int? votePowerReserveRate;

  const GlobalChainPropsModel({
    this.availableAccountSubsidies,
    this.contentRewardPercent,
    this.currentAslot,
    this.currentHbdSupply,
    this.currentRemoveThreshold,
    this.currentSupply,
    this.currentWitness,
    this.delegationReturnPeriod,
    this.dhfIntervalLedger,
    this.downvotePoolPercent,
    this.earlyVotingSeconds,
    this.hbdInterestRate,
    this.hbdPrintRate,
    this.hbdStartPercent,
    this.hbdStopPercent,
    this.headBlockId,
    this.headBlockNumber,
    this.initHbdSupply,
    this.lastBudgetTime,
    this.lastIrreversibleBlockNum,
    this.maxConsecutiveRecurrentTransferFailures,
    this.maxOpenRecurrentTransfers,
    this.maxRecurrentTransferEndDate,
    this.maximumBlockSize,
    this.midVotingSeconds,
    this.minRecurrentTransfersRecurrence,
    this.nextDailyMaintenanceTime,
    this.nextMaintenanceTime,
    this.numPowWitnesses,
    this.participationCount,
    this.pendingRewardedVestingHive,
    this.pendingRewardedVestingShares,
    this.proposalFundPercent,
    this.recentSlotsFilled,
    this.reverseAuctionSeconds,
    this.time,
    this.totalPow,
    this.totalRewardFundHive,
    this.totalRewardShares2,
    this.totalVestingFundHive,
    this.totalVestingShares,
    this.vestingRewardPercent,
    this.virtualSupply,
    this.votePowerReserveRate,
  });

  factory GlobalChainPropsModel.fromRawJson(String str) =>
      GlobalChainPropsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalChainPropsModel.fromJson(Map<String, dynamic> json) =>
      GlobalChainPropsModel(
        availableAccountSubsidies: json["available_account_subsidies"],
        contentRewardPercent: json["content_reward_percent"],
        currentAslot: json["current_aslot"],
        currentHbdSupply: json["current_hbd_supply"],
        currentRemoveThreshold: json["current_remove_threshold"],
        currentSupply: json["current_supply"],
        currentWitness: json["current_witness"],
        delegationReturnPeriod: json["delegation_return_period"],
        dhfIntervalLedger: json["dhf_interval_ledger"],
        downvotePoolPercent: json["downvote_pool_percent"],
        earlyVotingSeconds: json["early_voting_seconds"],
        hbdInterestRate: json["hbd_interest_rate"],
        hbdPrintRate: json["hbd_print_rate"],
        hbdStartPercent: json["hbd_start_percent"],
        hbdStopPercent: json["hbd_stop_percent"],
        headBlockId: json["head_block_id"],
        headBlockNumber: json["head_block_number"],
        initHbdSupply: json["init_hbd_supply"],
        lastBudgetTime: json["last_budget_time"] == null
            ? null
            : DateTime.parse(json["last_budget_time"]),
        lastIrreversibleBlockNum: json["last_irreversible_block_num"],
        maxConsecutiveRecurrentTransferFailures:
            json["max_consecutive_recurrent_transfer_failures"],
        maxOpenRecurrentTransfers: json["max_open_recurrent_transfers"],
        maxRecurrentTransferEndDate: json["max_recurrent_transfer_end_date"],
        maximumBlockSize: json["maximum_block_size"],
        midVotingSeconds: json["mid_voting_seconds"],
        minRecurrentTransfersRecurrence:
            json["min_recurrent_transfers_recurrence"],
        nextDailyMaintenanceTime: json["next_daily_maintenance_time"] == null
            ? null
            : DateTime.parse(json["next_daily_maintenance_time"]),
        nextMaintenanceTime: json["next_maintenance_time"] == null
            ? null
            : DateTime.parse(json["next_maintenance_time"]),
        numPowWitnesses: json["num_pow_witnesses"],
        participationCount: json["participation_count"],
        pendingRewardedVestingHive: json["pending_rewarded_vesting_hive"],
        pendingRewardedVestingShares: json["pending_rewarded_vesting_shares"],
        proposalFundPercent: json["proposal_fund_percent"],
        recentSlotsFilled: json["recent_slots_filled"],
        reverseAuctionSeconds: json["reverse_auction_seconds"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalPow: json["total_pow"],
        totalRewardFundHive: json["total_reward_fund_hive"],
        totalRewardShares2: json["total_reward_shares2"],
        totalVestingFundHive: json["total_vesting_fund_hive"],
        totalVestingShares: json["total_vesting_shares"],
        vestingRewardPercent: json["vesting_reward_percent"],
        virtualSupply: json["virtual_supply"],
        votePowerReserveRate: json["vote_power_reserve_rate"],
      );

  Map<String, dynamic> toJson() => {
        "available_account_subsidies": availableAccountSubsidies,
        "content_reward_percent": contentRewardPercent,
        "current_aslot": currentAslot,
        "current_hbd_supply": currentHbdSupply,
        "current_remove_threshold": currentRemoveThreshold,
        "current_supply": currentSupply,
        "current_witness": currentWitness,
        "delegation_return_period": delegationReturnPeriod,
        "dhf_interval_ledger": dhfIntervalLedger,
        "downvote_pool_percent": downvotePoolPercent,
        "early_voting_seconds": earlyVotingSeconds,
        "hbd_interest_rate": hbdInterestRate,
        "hbd_print_rate": hbdPrintRate,
        "hbd_start_percent": hbdStartPercent,
        "hbd_stop_percent": hbdStopPercent,
        "head_block_id": headBlockId,
        "head_block_number": headBlockNumber,
        "init_hbd_supply": initHbdSupply,
        "last_budget_time": lastBudgetTime?.toIso8601String(),
        "last_irreversible_block_num": lastIrreversibleBlockNum,
        "max_consecutive_recurrent_transfer_failures":
            maxConsecutiveRecurrentTransferFailures,
        "max_open_recurrent_transfers": maxOpenRecurrentTransfers,
        "max_recurrent_transfer_end_date": maxRecurrentTransferEndDate,
        "maximum_block_size": maximumBlockSize,
        "mid_voting_seconds": midVotingSeconds,
        "min_recurrent_transfers_recurrence": minRecurrentTransfersRecurrence,
        "next_daily_maintenance_time":
            nextDailyMaintenanceTime?.toIso8601String(),
        "next_maintenance_time": nextMaintenanceTime?.toIso8601String(),
        "num_pow_witnesses": numPowWitnesses,
        "participation_count": participationCount,
        "pending_rewarded_vesting_hive": pendingRewardedVestingHive,
        "pending_rewarded_vesting_shares": pendingRewardedVestingShares,
        "proposal_fund_percent": proposalFundPercent,
        "recent_slots_filled": recentSlotsFilled,
        "reverse_auction_seconds": reverseAuctionSeconds,
        "time": time?.toIso8601String(),
        "total_pow": totalPow,
        "total_reward_fund_hive": totalRewardFundHive,
        "total_reward_shares2": totalRewardShares2,
        "total_vesting_fund_hive": totalVestingFundHive,
        "total_vesting_shares": totalVestingShares,
        "vesting_reward_percent": vestingRewardPercent,
        "virtual_supply": virtualSupply,
        "vote_power_reserve_rate": votePowerReserveRate,
      };

  @override
  List<Object?> get props => [
        availableAccountSubsidies,
        contentRewardPercent,
        currentAslot,
        currentHbdSupply,
        currentRemoveThreshold,
        currentSupply,
        currentWitness,
        delegationReturnPeriod,
        dhfIntervalLedger,
        downvotePoolPercent,
        earlyVotingSeconds,
        hbdInterestRate,
        hbdPrintRate,
        hbdStartPercent,
        hbdStopPercent,
        headBlockId,
        headBlockNumber,
        initHbdSupply,
        lastBudgetTime,
        lastIrreversibleBlockNum,
        maxConsecutiveRecurrentTransferFailures,
        maxOpenRecurrentTransfers,
        maxRecurrentTransferEndDate,
        maximumBlockSize,
        midVotingSeconds,
        minRecurrentTransfersRecurrence,
        nextDailyMaintenanceTime,
        nextMaintenanceTime,
        numPowWitnesses,
        participationCount,
        pendingRewardedVestingHive,
        pendingRewardedVestingShares,
        proposalFundPercent,
        recentSlotsFilled,
        reverseAuctionSeconds,
        time,
        totalPow,
        totalRewardFundHive,
        totalRewardShares2,
        totalVestingFundHive,
        totalVestingShares,
        vestingRewardPercent,
        virtualSupply,
        votePowerReserveRate
      ];
}
