

class HbdExchangeRateModel {
    final String? base;
    final String? quote;

    HbdExchangeRateModel({
        this.base,
        this.quote,
    });

    HbdExchangeRateModel copyWith({
        String? base,
        String? quote,
    }) => 
        HbdExchangeRateModel(
            base: base ?? this.base,
            quote: quote ?? this.quote,
        );

    factory HbdExchangeRateModel.fromJson(Map<String, dynamic> json) => HbdExchangeRateModel(
        base: json["base"],
        quote: json["quote"],
    );

    Map<String, dynamic> toJson() => {
        "base": base,
        "quote": quote,
    };
}
