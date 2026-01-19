import 'package:flutter/foundation.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

enum SortOption {
  symbol,
  priceHighToLow,
  priceLowToHigh,
  changeHighToLow,
  changeLowToHigh,
}

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;
  SortOption _sortOption = SortOption.symbol;

  List<MarketData> get marketData => _getSortedData();
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _marketData.isNotEmpty;
  bool get hasError => _error != null;
  SortOption get sortOption => _sortOption;

  Future<void> loadMarketData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getMarketData();
      _marketData = data.map((json) => MarketData.fromJson(json)).toList();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _marketData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMarketData() async {
    await loadMarketData();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  List<MarketData> _getSortedData() {
    if (_marketData.isEmpty) return [];

    final sortedList = List<MarketData>.from(_marketData);
    switch (_sortOption) {
      case SortOption.symbol:
        sortedList.sort((a, b) => a.symbol.compareTo(b.symbol));
        break;
      case SortOption.priceHighToLow:
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.priceLowToHigh:
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.changeHighToLow:
        sortedList.sort((a, b) => b.changePercent24h.compareTo(a.changePercent24h));
        break;
      case SortOption.changeLowToHigh:
        sortedList.sort((a, b) => a.changePercent24h.compareTo(b.changePercent24h));
        break;
    }
    return List.unmodifiable(sortedList);
  }

  String getSortLabel(SortOption option, AppLocalizations l10n) {
    switch (option) {
      case SortOption.symbol:
        return l10n.sortSymbol;
      case SortOption.priceHighToLow:
        return l10n.sortPriceHighToLow;
      case SortOption.priceLowToHigh:
        return l10n.sortPriceLowToHigh;
      case SortOption.changeHighToLow:
        return l10n.sortChangeHighToLow;
      case SortOption.changeLowToHigh:
        return l10n.sortChangeLowToHigh;
    }
  }
}
