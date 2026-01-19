// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PulseNow';

  @override
  String get switchToLightMode => 'Switch to Light Mode';

  @override
  String get switchToDarkMode => 'Switch to Dark Mode';

  @override
  String get searchHint => 'Search by symbol or name...';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get about => 'About';

  @override
  String get marketStatistics => 'Market Statistics';

  @override
  String get marketCap => 'Market Cap';

  @override
  String get volume24h => 'Volume (24h)';

  @override
  String get high24h => '24h High';

  @override
  String get low24h => '24h Low';

  @override
  String get volume => 'Volume';

  @override
  String get portfolioHoldings => 'Portfolio Holdings';

  @override
  String get noHoldingsFound => 'No holdings found';

  @override
  String get portfolioValue => 'Portfolio Value';

  @override
  String get holdings => 'Holdings';

  @override
  String get totalPnl => 'Total P&L';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get averagePrice => 'Average Price';

  @override
  String get portfolioAllocation => 'Portfolio Allocation';

  @override
  String get performance => 'Performance';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get startValue => 'Start Value';

  @override
  String get endValue => 'End Value';

  @override
  String get totalReturn => 'Total Return';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortSymbol => 'Symbol';

  @override
  String get sortPriceHighToLow => 'Price: High to Low';

  @override
  String get sortPriceLowToHigh => 'Price: Low to High';

  @override
  String get sortChangeHighToLow => 'Change: High to Low';

  @override
  String get sortChangeLowToHigh => 'Change: Low to High';

  @override
  String get errorTitle => 'Oops! Something went wrong';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noMarketData => 'No market data available';
}
