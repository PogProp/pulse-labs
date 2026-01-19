import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/market_data_model.dart';
import '../utils/constants.dart';
import 'info_item.dart';

class MarketDataCard extends StatelessWidget {
  final MarketData marketData;

  const MarketDataCard({
    super.key,
    required this.marketData,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );

    final percentFormatter = NumberFormat('+#,##0.00;-#,##0.00');
    final changeColor = marketData.isPositiveChange
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Optional: Navigate to detail view
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                currencyFormatter,
                percentFormatter,
                changeColor,
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _buildMarketInfo(currencyFormatter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    NumberFormat currencyFormatter,
    NumberFormat percentFormatter,
    Color changeColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                marketData.symbol,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currencyFormatter.format(marketData.price),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: changeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${percentFormatter.format(marketData.changePercent24h)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: changeColor,
                ),
              ),
              Text(
                currencyFormatter.format(marketData.change24h),
                style: TextStyle(
                  fontSize: 12,
                  color: changeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMarketInfo(NumberFormat currencyFormatter) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoItem(
              label: '24h High',
              value: currencyFormatter.format(marketData.high24h),
            ),
            InfoItem(
              label: '24h Low',
              value: currencyFormatter.format(marketData.low24h),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoItem(
              label: 'Volume',
              value: _formatVolume(marketData.volume),
            ),
            InfoItem(
              label: 'Market Cap',
              value: _formatMarketCap(marketData.marketCap),
            ),
          ],
        ),
      ],
    );
  }

  String _formatVolume(double volume) {
    if (volume >= 1e9) {
      return '\$${(volume / 1e9).toStringAsFixed(2)}B';
    } else if (volume >= 1e6) {
      return '\$${(volume / 1e6).toStringAsFixed(2)}M';
    } else {
      return '\$${volume.toStringAsFixed(0)}';
    }
  }

  String _formatMarketCap(double marketCap) {
    if (marketCap >= 1e9) {
      return '\$${(marketCap / 1e9).toStringAsFixed(2)}B';
    } else if (marketCap >= 1e6) {
      return '\$${(marketCap / 1e6).toStringAsFixed(2)}M';
    } else {
      return '\$${marketCap.toStringAsFixed(0)}';
    }
  }
}
