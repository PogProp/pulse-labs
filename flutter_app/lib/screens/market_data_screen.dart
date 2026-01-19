import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';
import '../widgets/market_data_card.dart';
import '../widgets/error_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/animated_list_item.dart';
import '../widgets/sort_bottom_sheet.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Provider.of<MarketDataProvider>(context, listen: false)
        .refreshMarketData();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
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

        final filteredData = _searchQuery.isEmpty
            ? provider.marketData
            : provider.marketData
                .where((data) =>
                    data.symbol.toLowerCase().contains(_searchQuery) ||
                    data.description.toLowerCase().contains(_searchQuery))
                .toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search by symbol or name...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => SortBottomSheet.show(context, provider),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: const Icon(
                          Icons.sort,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredData.isEmpty
                  ? const EmptyState(
                      message: 'No results found',
                    )
                  : RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: filteredData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12.0),
                        itemBuilder: (context, index) {
                          final marketData = filteredData[index];
                          return AnimatedListItem(
                            index: index,
                            child: MarketDataCard(marketData: marketData),
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
