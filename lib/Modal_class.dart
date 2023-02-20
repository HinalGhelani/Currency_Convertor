class Currency {
  final dynamic inr;
  final dynamic usd;
  final dynamic cad;
  final dynamic gbp;

  Currency({
    required this.inr,
    required this.usd,
    required this.cad,
    required this.gbp,
  });

  factory Currency.fromJson({required Map json}){
    return Currency(
      inr: json['conversion_rates']['INR'],
      usd: json['conversion_rates']['USD'],
      cad: json['conversion_rates']['CAD'],
      gbp: json['conversion_rates']['GBP'],
    );
  }
}
