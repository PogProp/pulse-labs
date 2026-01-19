import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale ?? Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      tooltip: 'Change Language',
      onSelected: (Locale locale) {
        localeProvider.setLocale(locale);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<Locale>(
            value: const Locale('en'),
            child: Row(
              children: [
                const Text('🇬🇧', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                const Text('English'),
                if (currentLocale.languageCode == 'en') ...[
                  const Spacer(),
                  const Icon(Icons.check, color: Colors.blue, size: 20),
                ],
              ],
            ),
          ),
          PopupMenuItem<Locale>(
            value: const Locale('fr'),
            child: Row(
              children: [
                const Text('🇫🇷', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                const Text('Français'),
                if (currentLocale.languageCode == 'fr') ...[
                  const Spacer(),
                  const Icon(Icons.check, color: Colors.blue, size: 20),
                ],
              ],
            ),
          ),
        ];
      },
    );
  }
}
