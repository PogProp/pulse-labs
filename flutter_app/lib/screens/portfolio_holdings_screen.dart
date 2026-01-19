import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../widgets/portfolio_holding_card.dart';
import '../widgets/portfolio_performance_chart.dart';
import '../widgets/error_state.dart';
import '../widgets/empty_state.dart';

class PortfolioHoldingsScreen extends StatefulWidget {
  const PortfolioHoldingsScreen({super.key});

  @override
  State<PortfolioHoldingsScreen> createState() =>
      _PortfolioHoldingsScreenState();
}

class _PortfolioHoldingsScreenState extends State<PortfolioHoldingsScreen> {
  String _selectedTimeframe = '7d';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PortfolioProvider>(context, listen: false);
      provider.loadHoldings();
      provider.loadPerformance(timeframe: _selectedTimeframe);
    });
  }

  Future<void> _handleRefresh() async {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    await Future.wait([
      provider.refreshHoldings(),
      provider.refreshPerformance(timeframe: _selectedTimeframe),
    ]);
  }

  void _handleTimeframeChange(String timeframe) {
    setState(() {
      _selectedTimeframe = timeframe;
    });
    Provider.of<PortfolioProvider>(context, listen: false)
        .loadPerformance(timeframe: timeframe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Holdings'),
        elevation: 0,
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingHoldings && !provider.hasHoldings) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.holdingsError != null && !provider.hasHoldings) {
            return ErrorState(
              errorMessage: provider.holdingsError,
              onRetry: () => provider.loadHoldings(),
            );
          }

          if (!provider.hasHoldings) {
            return const EmptyState(
              message: 'No holdings found',
            );
          }

          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16.0),
              itemCount: provider.holdings.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return provider.hasPerformance
                      ? PortfolioPerformanceChart(
                          performance: provider.performance!,
                          onTimeframeChanged: _handleTimeframeChange,
                          selectedTimeframe: _selectedTimeframe,
                        )
                      : provider.isLoadingPerformance
                          ? Container(
                              margin: const EdgeInsets.all(16.0),
                              height: 400,
                              child: const Card(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : provider.performanceError != null
                              ? Container(
                                  margin: const EdgeInsets.all(16.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ErrorState(
                                        errorMessage: provider.performanceError,
                                        onRetry: () => provider.loadPerformance(
                                            timeframe: _selectedTimeframe),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                }

                final holdingIndex = index - 1;
                final holding = provider.holdings[holdingIndex];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.0,
                    holdingIndex == 0 ? 8.0 : 0.0,
                    16.0,
                    holdingIndex == provider.holdings.length - 1 ? 0.0 : 12.0,
                  ),
                  child: PortfolioHoldingCard(holding: holding),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
