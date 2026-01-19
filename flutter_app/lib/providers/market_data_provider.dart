import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MarketData> _marketData = [];
  bool _isLoading = false;
  String? _error;

  List<MarketData> get marketData => List.unmodifiable(_marketData);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _marketData.isNotEmpty;
  bool get hasError => _error != null;

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
}
