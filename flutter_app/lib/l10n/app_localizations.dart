import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'PulseNow'**
  String get appTitle;

  /// Tooltip for switching to light theme
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Mode'**
  String get switchToLightMode;

  /// Tooltip for switching to dark theme
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Mode'**
  String get switchToDarkMode;

  /// Hint text for the search field
  ///
  /// In en, this message translates to:
  /// **'Search by symbol or name...'**
  String get searchHint;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Section header for about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Section header for market statistics
  ///
  /// In en, this message translates to:
  /// **'Market Statistics'**
  String get marketStatistics;

  /// Label for market capitalization
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get marketCap;

  /// Label for 24-hour trading volume
  ///
  /// In en, this message translates to:
  /// **'Volume (24h)'**
  String get volume24h;

  /// Label for 24-hour high price
  ///
  /// In en, this message translates to:
  /// **'24h High'**
  String get high24h;

  /// Label for 24-hour low price
  ///
  /// In en, this message translates to:
  /// **'24h Low'**
  String get low24h;

  /// Label for trading volume
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// Title for portfolio holdings screen
  ///
  /// In en, this message translates to:
  /// **'Portfolio Holdings'**
  String get portfolioHoldings;

  /// Message when portfolio has no holdings
  ///
  /// In en, this message translates to:
  /// **'No holdings found'**
  String get noHoldingsFound;

  /// Label for total portfolio value
  ///
  /// In en, this message translates to:
  /// **'Portfolio Value'**
  String get portfolioValue;

  /// Label for number of holdings
  ///
  /// In en, this message translates to:
  /// **'Holdings'**
  String get holdings;

  /// Label for total profit and loss
  ///
  /// In en, this message translates to:
  /// **'Total P&L'**
  String get totalPnl;

  /// Label for current price
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get currentPrice;

  /// Label for average purchase price
  ///
  /// In en, this message translates to:
  /// **'Average Price'**
  String get averagePrice;

  /// Label for portfolio allocation percentage
  ///
  /// In en, this message translates to:
  /// **'Portfolio Allocation'**
  String get portfolioAllocation;

  /// Chart header for performance chart
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// Message when no data is available for chart
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// Label for starting value in performance summary
  ///
  /// In en, this message translates to:
  /// **'Start Value'**
  String get startValue;

  /// Label for ending value in performance summary
  ///
  /// In en, this message translates to:
  /// **'End Value'**
  String get endValue;

  /// Label for total return in performance summary
  ///
  /// In en, this message translates to:
  /// **'Total Return'**
  String get totalReturn;

  /// Title for sort bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// Sort option by symbol
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get sortSymbol;

  /// Sort option by price descending
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get sortPriceHighToLow;

  /// Sort option by price ascending
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get sortPriceLowToHigh;

  /// Sort option by change descending
  ///
  /// In en, this message translates to:
  /// **'Change: High to Low'**
  String get sortChangeHighToLow;

  /// Sort option by change ascending
  ///
  /// In en, this message translates to:
  /// **'Change: Low to High'**
  String get sortChangeLowToHigh;

  /// Title for error state
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get errorTitle;

  /// Default error message
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get unknownError;

  /// Button label to retry after error
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Default empty state message for market data
  ///
  /// In en, this message translates to:
  /// **'No market data available'**
  String get noMarketData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
