import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/market_data_model.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/number_formatters.dart';
import '../screens/market_detail_screen.dart';
import 'info_item.dart';

class MarketDataCard extends StatelessWidget {
  final MarketData marketData;

  const MarketDataCard({
    super.key,
    required this.marketData,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MarketDetailScreen(marketData: marketData),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(changeColor),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _buildMarketInfo(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color changeColor) {
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
                Formatters.currencyFormatter.format(marketData.price),
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
                '${Formatters.percentFormatter.format(marketData.changePercent24h)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: changeColor,
                ),
              ),
              Text(
                Formatters.currencyFormatter.format(marketData.change24h),
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

  Widget _buildMarketInfo(AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoItem(
              label: l10n.high24h,
              value: Formatters.currencyFormatter.format(marketData.high24h),
            ),
            InfoItem(
              label: l10n.low24h,
              value: Formatters.currencyFormatter.format(marketData.low24h),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoItem(
              label: l10n.volume,
              value: formatLargeCurrency(marketData.volume),
            ),
            InfoItem(
              label: l10n.marketCap,
              value: formatLargeCurrency(marketData.marketCap),
            ),
          ],
        ),
      ],
    );
  }
}
