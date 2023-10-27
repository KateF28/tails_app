import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends InheritedWidget {
  Locale _locale;
  VoidCallback stateUpdate = () {};

  LocaleProvider({super.key, required super.child})
      : _locale = const Locale('uk', 'UA');

  void changeLocale(Locale newLocale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocale.languageCode);
    prefs.setString('countryCode', newLocale.countryCode ?? '');

    _locale = newLocale;
    stateUpdate.call();
  }

  void updateState(VoidCallback newCallback) {
    stateUpdate = newCallback;
    stateUpdate.call();
  }

  static LocaleProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
    if (provider == null) throw FlutterError('LocaleProvider not found');
    return provider;
  }

  static Locale localeOf(BuildContext context) =>
      LocaleProvider.of(context)._locale;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
