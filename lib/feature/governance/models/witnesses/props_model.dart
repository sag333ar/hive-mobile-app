class PropsModel {
  final String? accountCreationFee;
  final int? accountSubsidyBudget;
  final int? accountSubsidyDecay;
  final int? hbdInterestRate;
  final int? maximumBlockSize;

  const PropsModel({
    this.accountCreationFee,
    this.accountSubsidyBudget,
    this.accountSubsidyDecay,
    this.hbdInterestRate,
    this.maximumBlockSize,
  });

  PropsModel copyWith({
    String? accountCreationFee,
    int? accountSubsidyBudget,
    int? accountSubsidyDecay,
    int? hbdInterestRate,
    int? maximumBlockSize,
  }) =>
      PropsModel(
        accountCreationFee: accountCreationFee ?? this.accountCreationFee,
        accountSubsidyBudget: accountSubsidyBudget ?? this.accountSubsidyBudget,
        accountSubsidyDecay: accountSubsidyDecay ?? this.accountSubsidyDecay,
        hbdInterestRate: hbdInterestRate ?? this.hbdInterestRate,
        maximumBlockSize: maximumBlockSize ?? this.maximumBlockSize,
      );

  factory PropsModel.fromJson(Map<String, dynamic> json) => PropsModel(
        accountCreationFee: json["account_creation_fee"],
        accountSubsidyBudget: json["account_subsidy_budget"],
        accountSubsidyDecay: json["account_subsidy_decay"],
        hbdInterestRate: json["hbd_interest_rate"],
        maximumBlockSize: json["maximum_block_size"],
      );

  Map<String, dynamic> toJson() => {
        "account_creation_fee": accountCreationFee,
        "account_subsidy_budget": accountSubsidyBudget,
        "account_subsidy_decay": accountSubsidyDecay,
        "hbd_interest_rate": hbdInterestRate,
        "maximum_block_size": maximumBlockSize,
      };
}
