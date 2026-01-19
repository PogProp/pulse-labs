class PortfolioSummary {
  final double totalValue;
  final double totalPnl;
  final double totalPnlPercent;
  final int totalHoldings;
  final String lastUpdated;

  PortfolioSummary({
    required this.totalValue,
    required this.totalPnl,
    required this.totalPnlPercent,
    required this.totalHoldings,
    required this.lastUpdated,
  });

  factory PortfolioSummary.fromJson(Map<String, dynamic> json) {
    return PortfolioSummary(
      totalValue: double.parse(json['totalValue'] as String),
      totalPnl: double.parse(json['totalPnl'] as String),
      totalPnlPercent: double.parse(json['totalPnlPercent'] as String),
      totalHoldings: json['totalHoldings'] as int,
      lastUpdated: json['lastUpdated'] as String,
    );
  }

  bool get isPositivePnl => totalPnl >= 0;
}
