import 'package:flutter/material.dart';
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
            _buildAboutSection(),
            const SizedBox(height: 24),
            _buildStatisticsSection(),
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

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          marketData.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Market Statistics',
          style: TextStyle(
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
                      label: 'Market Cap',
                      value: formatLargeCurrency(marketData.marketCap),
                    ),
                    InfoItem(
                      label: 'Volume (24h)',
                      value: formatLargeCurrency(marketData.volume),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoItem(
                      label: '24h High',
                      value: Formatters.currencyFormatter.format(marketData.high24h),
                    ),
                    InfoItem(
                      label: '24h Low',
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
