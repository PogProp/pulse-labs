// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PulseNow';

  @override
  String get switchToLightMode => 'Passer en mode clair';

  @override
  String get switchToDarkMode => 'Passer en mode sombre';

  @override
  String get searchHint => 'Rechercher par symbole ou nom...';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get about => 'À propos';

  @override
  String get marketStatistics => 'Statistiques du marché';

  @override
  String get marketCap => 'Capitalisation';

  @override
  String get volume24h => 'Volume (24h)';

  @override
  String get high24h => 'Plus haut 24h';

  @override
  String get low24h => 'Plus bas 24h';

  @override
  String get volume => 'Volume';

  @override
  String get portfolioHoldings => 'Avoirs du portefeuille';

  @override
  String get noHoldingsFound => 'Aucun avoir trouvé';

  @override
  String get portfolioValue => 'Valeur du portefeuille';

  @override
  String get holdings => 'Avoirs';

  @override
  String get totalPnl => 'P&P Total';

  @override
  String get currentPrice => 'Prix actuel';

  @override
  String get averagePrice => 'Prix moyen';

  @override
  String get portfolioAllocation => 'Allocation du portefeuille';

  @override
  String get performance => 'Performance';

  @override
  String get noDataAvailable => 'Aucune donnée disponible';

  @override
  String get startValue => 'Valeur initiale';

  @override
  String get endValue => 'Valeur finale';

  @override
  String get totalReturn => 'Rendement total';

  @override
  String get sortBy => 'Trier par';

  @override
  String get sortSymbol => 'Symbole';

  @override
  String get sortPriceHighToLow => 'Prix : du plus élevé au plus bas';

  @override
  String get sortPriceLowToHigh => 'Prix : du plus bas au plus élevé';

  @override
  String get sortChangeHighToLow =>
      'Variation : de la plus élevée à la plus basse';

  @override
  String get sortChangeLowToHigh =>
      'Variation : de la plus basse à la plus élevée';

  @override
  String get errorTitle => 'Oups ! Une erreur s\'est produite';

  @override
  String get unknownError => 'Une erreur inconnue s\'est produite';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get noMarketData => 'Aucune donnée de marché disponible';
}
