import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';
import '../widgets/market_data_card.dart';
import '../widgets/error_state.dart';
import '../widgets/empty_state.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
    });
  }

  Future<void> _handleRefresh() async {
    await Provider.of<MarketDataProvider>(context, listen: false)
        .refreshMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && !provider.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.hasError && !provider.hasData) {
          return ErrorState(
            errorMessage: provider.error,
            onRetry: () => provider.loadMarketData(),
          );
        }

        if (!provider.hasData) {
          return const EmptyState();
        }

        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.marketData.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final marketData = provider.marketData[index];
              return MarketDataCard(marketData: marketData);
            },
          ),
        );
      },
    );
  }
}
