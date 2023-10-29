import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale;

  LocaleNotifier(this._locale);

  void changeLocale(Locale newLocale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocale.languageCode);
    prefs.setString('countryCode', newLocale.countryCode ?? '');

    _locale = newLocale;
    notifyListeners();
  }

  Locale get locale => _locale;
}
