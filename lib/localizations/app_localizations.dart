import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static List<LocalizationsDelegate> get localizationsDelegates {
    return [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      AppLocalizations.delegate,
    ];
  }

  static List<Locale> get supportedLocales {
    return [
      const Locale('en', ''),
      const Locale('tr', ''),
    ];
  }

  Map<String, String> _localizedStrings = {
    'title': 'Başlık',
    'subtitle': 'Alt Başlık',
  };

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
