# Localization Implementation

This Flutter app now supports internationalization (i18n) with English and French translations.

## Overview

The app uses Flutter's built-in localization support with ARB (Application Resource Bundle) files.

## Supported Languages

- **English (en)** - Default language
- **French (fr)** - Complete translation

## How It Works

### File Structure

```
flutter_app/
├── l10n.yaml                       # Localization configuration
├── lib/
│   └── l10n/
│       ├── app_en.arb             # English translations
│       ├── app_fr.arb             # French translations
│       ├── app_localizations.dart  # Generated localization class
│       ├── app_localizations_en.dart
│       └── app_localizations_fr.dart
```

### Configuration Files

1. **l10n.yaml** - Configuration file for localization generation
2. **pubspec.yaml** - Contains `generate: true` flag and required dependencies
3. **ARB files** - JSON-based translation files with string keys and translations

## Adding New Translations

### 1. Add String to English ARB File

Edit [lib/l10n/app_en.arb](lib/l10n/app_en.arb):

```json
{
  "myNewString": "Hello World",
  "@myNewString": {
    "description": "Greeting message"
  }
}
```

### 2. Add Translation to French ARB File

Edit [lib/l10n/app_fr.arb](lib/l10n/app_fr.arb):

```json
{
  "myNewString": "Bonjour le monde",
  "@myNewString": {
    "description": "Message de salutation"
  }
}
```

### 3. Regenerate Localization Files

Run:
```bash
flutter pub get
```

The localization files will be automatically regenerated.

### 4. Use in Your Code

```dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(l10n.myNewString);
  }
}
```

## How the App Detects Language

The app provides two ways to change the language:

### 1. In-App Language Switcher (Recommended) 🌐

You can change the language directly within the app:
1. Look for the **language icon** (🌐) in the top-right corner of the app bar
2. Tap the icon to open the language menu
3. Select your preferred language:
   - 🇬🇧 **English**
   - 🇫🇷 **Français**
4. The app will instantly switch to the selected language

The language preference is saved and will persist when you restart the app.

### 2. Device Language Settings

The app also automatically detects the device's language setting and displays the appropriate translation:
- If device is set to French → Shows French translations
- If device is set to English or any other language → Shows English translations (default)

**Note:** The in-app language selector overrides the device language setting.

## Testing Different Languages

### iOS Simulator
1. Open Settings app
2. Go to General → Language & Region
3. Add French (Français) or change preferred language order
4. Restart the app

### Android Emulator
1. Open Settings
2. Go to System → Languages & input → Languages
3. Add French (Français) or change language order
4. Restart the app

### Programmatically (for testing)
You can also force a specific locale in your code:

```dart
MaterialApp(
  locale: const Locale('fr'), // Force French
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
)
```

## All Translated Strings

The following strings are translated throughout the app:

### General
- App title
- Theme toggle tooltips

### Search & Sort
- Search hint text
- Sort options (by symbol, price, change)

### Market Data
- Market statistics labels
- Price indicators (24h high/low, volume, market cap)

### Portfolio
- Portfolio value and holdings
- Performance metrics
- P&L indicators
- Allocation labels

### UI States
- Error messages
- Empty states
- Loading states
- Action buttons

## Technical Details

### Dependencies

- `flutter_localizations` - Flutter SDK package for localization
- `intl: ^0.20.2` - Internationalization and localization facilities

### Generated Files

The localization files are automatically generated in [lib/l10n/](lib/l10n/) when you run `flutter pub get`. These files should not be edited manually.

### Clean Code Practices

- All user-facing strings use localization
- No hardcoded strings in UI components
- Consistent naming convention for translation keys
- Descriptive comments in ARB files for context

## Adding More Languages

To add support for additional languages (e.g., Spanish):

1. Create `lib/l10n/app_es.arb` with Spanish translations
2. Add the locale to supported locales in [main.dart](lib/main.dart):
   ```dart
   supportedLocales: const [
     Locale('en', ''),
     Locale('fr', ''),
     Locale('es', ''), // Add Spanish
   ],
   ```
3. Run `flutter pub get` to regenerate localization files

## Troubleshooting

### Localization files not generating
- Ensure `generate: true` is set in `pubspec.yaml` under the `flutter:` section
- Run `flutter clean && flutter pub get`
- Check that `l10n.yaml` exists in the root of your Flutter project

### Strings not translating
- Verify the locale is in `supportedLocales` list
- Check that both ARB files have the same keys
- Restart the app after changing device language

### Compilation errors
- Make sure to import the localization file: `import '../l10n/app_localizations.dart';`
- Ensure you're calling `AppLocalizations.of(context)!` in a widget with access to context
