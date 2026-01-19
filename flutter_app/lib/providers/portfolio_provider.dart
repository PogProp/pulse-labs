import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/portfolio_model.dart';

class PortfolioProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  PortfolioSummary? _summary;
  bool _isLoading = false;
  String? _error;

  PortfolioSummary? get summary => _summary;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _summary != null;
  bool get hasError => _error != null;

  Future<void> loadPortfolioSummary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getPortfolio();
      _summary = PortfolioSummary.fromJson(data);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _summary = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPortfolio() async {
    await loadPortfolioSummary();
  }
}
