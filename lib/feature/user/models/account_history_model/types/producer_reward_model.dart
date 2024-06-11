import 'package:hive_mobile_app/feature/user/models/account_history_model/account_history_data_model_absctract.dart';

class ProducerRewardModel implements AccountHistoryDataModel{
    final String? producer;
    final String? vestingShares;

    ProducerRewardModel({
        this.producer,
        this.vestingShares,
    });

    factory ProducerRewardModel.fromJson(Map<String, dynamic> json) => ProducerRewardModel(
        producer: json["producer"],
        vestingShares: json["vesting_shares"],
    );

    Map<String, dynamic> toJson() => {
        "producer": producer,
        "vesting_shares": vestingShares,
    };
}
