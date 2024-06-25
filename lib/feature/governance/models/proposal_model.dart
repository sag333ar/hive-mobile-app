import 'package:hive_mobile_app/core/utilities/save_convert.dart';

class ProposalModel {
    final String creator;
    final String dailyPay;
    final DateTime endDate;
    final int id;
    final String permlink;
    final int proposalId;
    final String receiver;
    final DateTime startDate;
    final String subject;
    final String totalVotes;

    ProposalModel({
        required this.creator,
        required this.dailyPay,
        required this.endDate,
        required this.id,
        required this.permlink,
        required this.proposalId,
        required this.receiver,
        required this.startDate,
        required this.subject,
        required this.totalVotes,
    });

  get owner => null;

    ProposalModel copyWith({
        String? creator,
        String? dailyPay,
        DateTime? endDate,
        int? id,
        String? permlink,
        int? proposalId,
        String? receiver,
        DateTime? startDate,
        String? subject,
        String? totalVotes,
    }) => 
        ProposalModel(
            creator: creator ?? this.creator,
            dailyPay: dailyPay ?? this.dailyPay,
            endDate: endDate ?? this.endDate,
            id: id ?? this.id,
            permlink: permlink ?? this.permlink,
            proposalId: proposalId ?? this.proposalId,
            receiver: receiver ?? this.receiver,
            startDate: startDate ?? this.startDate,
            subject: subject ?? this.subject,
            totalVotes: totalVotes ?? this.totalVotes,
        );

    factory ProposalModel.fromJson(Map<String, dynamic> json) => ProposalModel(
        creator: asString(json, "creator") ,
        dailyPay: asString(json, "daily_pay"),
        endDate: DateTime.parse(json["end_date"]),
        id: asInt(json, "id") ,
        permlink: asString(json, "permlink"),
        proposalId:asInt(json, "proposal_id") ,
        receiver: asString(json, "receiver") ,
        startDate: DateTime.parse(json["start_date"]),
        subject: asString(json, "subject"),
        totalVotes:asString(json, "total_votes") 
    );

    Map<String, dynamic> toJson() => {
        "creator": creator,
        "daily_pay": dailyPay,
        "end_date": endDate.toIso8601String(),
        "id": id,
        "permlink": permlink,
        "proposal_id": proposalId,
        "receiver": receiver,
        "start_date": startDate.toIso8601String(),
        "subject": subject,
        "total_votes": totalVotes,
    };
}
