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

class PortfolioHolding {
  final String id;
  final String symbol;
  final double quantity;
  final double averagePrice;
  final double currentPrice;
  final double value;
  final double pnl;
  final double pnlPercent;
  final double allocation;
  final String lastUpdated;

  PortfolioHolding({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.value,
    required this.pnl,
    required this.pnlPercent,
    required this.allocation,
    required this.lastUpdated,
  });

  factory PortfolioHolding.fromJson(Map<String, dynamic> json) {
    return PortfolioHolding(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      pnl: (json['pnl'] as num).toDouble(),
      pnlPercent: (json['pnlPercent'] as num).toDouble(),
      allocation: (json['allocation'] as num).toDouble(),
      lastUpdated: json['lastUpdated'] as String,
    );
  }

  bool get isPositivePnl => pnl >= 0;
}

class PortfolioPerformancePoint {
  final String timestamp;
  final double value;
  final double pnl;
  final double pnlPercent;

  PortfolioPerformancePoint({
    required this.timestamp,
    required this.value,
    required this.pnl,
    required this.pnlPercent,
  });

  factory PortfolioPerformancePoint.fromJson(Map<String, dynamic> json) {
    return PortfolioPerformancePoint(
      timestamp: json['timestamp'] as String,
      value: (json['value'] as num).toDouble(),
      pnl: double.parse(json['pnl'] as String),
      pnlPercent: double.parse(json['pnlPercent'] as String),
    );
  }

  DateTime get date => DateTime.parse(timestamp);
}

class PortfolioPerformanceSummary {
  final double startValue;
  final double endValue;
  final double totalReturn;

  PortfolioPerformanceSummary({
    required this.startValue,
    required this.endValue,
    required this.totalReturn,
  });

  factory PortfolioPerformanceSummary.fromJson(Map<String, dynamic> json) {
    return PortfolioPerformanceSummary(
      startValue: double.parse(json['startValue'] as String),
      endValue: double.parse(json['endValue'] as String),
      totalReturn: double.parse(json['totalReturn'] as String),
    );
  }

  bool get isPositiveReturn => totalReturn >= 0;
}

class PortfolioPerformance {
  final String timeframe;
  final List<PortfolioPerformancePoint> data;
  final PortfolioPerformanceSummary summary;

  PortfolioPerformance({
    required this.timeframe,
    required this.data,
    required this.summary,
  });

  factory PortfolioPerformance.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List;
    return PortfolioPerformance(
      timeframe: json['timeframe'] as String,
      data: dataList
          .map((point) => PortfolioPerformancePoint.fromJson(point))
          .toList(),
      summary: PortfolioPerformanceSummary.fromJson(json['summary']),
    );
  }
}
