import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/market_data_model.dart';
import '../utils/formatters.dart';
import '../utils/number_formatters.dart';
import '../widgets/price_change_badge.dart';
import '../widgets/info_item.dart';

class MarketDetailScreen extends StatelessWidget {
  final MarketData marketData;

  const MarketDetailScreen({
    super.key,
    required this.marketData,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(marketData.symbol),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceSection(),
            const SizedBox(height: 24),
            _buildAboutSection(context, l10n),
            const SizedBox(height: 24),
            _buildStatisticsSection(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Formatters.currencyFormatter.format(marketData.price),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        PriceChangeBadge(
          marketData: marketData,
          showIcon: true,
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.about,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          marketData.description,
          style: TextStyle(
            fontSize: 16,
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.marketStatistics,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoItem(
                      label: l10n.marketCap,
                      value: formatLargeCurrency(marketData.marketCap),
                    ),
                    InfoItem(
                      label: l10n.volume24h,
                      value: formatLargeCurrency(marketData.volume),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
