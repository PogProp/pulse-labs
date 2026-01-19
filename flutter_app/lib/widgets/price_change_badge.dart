import 'package:flutter/material.dart';
import '../models/market_data_model.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class PriceChangeBadge extends StatelessWidget {
  final MarketData marketData;
  final bool showIcon;

  const PriceChangeBadge({
    super.key,
    required this.marketData,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = marketData.isPositiveChange
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: changeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              marketData.isPositiveChange
                  ? Icons.trending_up
                  : Icons.trending_down,
              color: changeColor,
              size: 20,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '${Formatters.percentFormatter.format(marketData.changePercent24h)}%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}
