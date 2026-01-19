import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/portfolio_model.dart';

class PortfolioProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  PortfolioSummary? _summary;
  List<PortfolioHolding> _holdings = [];
  PortfolioPerformance? _performance;
  bool _isLoading = false;
  bool _isLoadingHoldings = false;
  bool _isLoadingPerformance = false;
  String? _error;
  String? _holdingsError;
  String? _performanceError;

  PortfolioSummary? get summary => _summary;
  List<PortfolioHolding> get holdings => List.unmodifiable(_holdings);
  PortfolioPerformance? get performance => _performance;
  bool get isLoading => _isLoading;
  bool get isLoadingHoldings => _isLoadingHoldings;
  bool get isLoadingPerformance => _isLoadingPerformance;
  String? get error => _error;
  String? get holdingsError => _holdingsError;
  String? get performanceError => _performanceError;
  bool get hasData => _summary != null;
  bool get hasHoldings => _holdings.isNotEmpty;
  bool get hasPerformance => _performance != null;
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

  Future<void> loadHoldings() async {
    _isLoadingHoldings = true;
    _holdingsError = null;
    notifyListeners();

    try {
      final data = await _apiService.getPortfolioHoldings();
      _holdings = data.map((json) => PortfolioHolding.fromJson(json)).toList();
      _holdingsError = null;
    } catch (e) {
      _holdingsError = e.toString();
      _holdings = [];
    } finally {
      _isLoadingHoldings = false;
      notifyListeners();
    }
  }

  Future<void> refreshHoldings() async {
    await loadHoldings();
  }

  Future<void> loadPerformance({String timeframe = '7d'}) async {
    _isLoadingPerformance = true;
    _performanceError = null;
    notifyListeners();

    try {
      final data = await _apiService.getPortfolioPerformance(
        timeframe: timeframe,
      );
      _performance = PortfolioPerformance.fromJson(data);
      _performanceError = null;
    } catch (e) {
      _performanceError = e.toString();
      _performance = null;
    } finally {
      _isLoadingPerformance = false;
      notifyListeners();
    }
  }

  Future<void> refreshPerformance({String timeframe = '7d'}) async {
    await loadPerformance(timeframe: timeframe);
  }
}
