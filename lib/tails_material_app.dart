import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/main_screen.dart';
import 'package:tails_app/data/datasources/local/locale_notifier.dart';
import 'package:tails_app/data/repository.dart';
import 'package:tails_app/data/api/mock_api.dart';

class TailsMaterialApp extends StatefulWidget {
  const TailsMaterialApp({super.key});

  @override
  State<TailsMaterialApp> createState() => _TailsMaterialAppState();
}

class _TailsMaterialAppState extends State<TailsMaterialApp> {
  final bool _useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  static const _colorSchemeSeed = Color(0xFF7950f2);

  @override
  void didChangeDependencies() {
    _fetchLocale().then((locale) {
      context.read<LocaleNotifier>().changeLocale(locale);
    });
    super.didChangeDependencies();
  }

  /*
  To get local from SharedPreferences if exists
   */
  Future<Locale> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('languageCode') ?? 'uk';
    String countryCode = prefs.getString('countryCode') ?? 'UA';

    return Locale(languageCode, countryCode);
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleNotifier>(
        builder: (BuildContext context, LocaleNotifier value, Widget? child) {
      return MaterialApp(
        title: 'Tails App',
        locale: value.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('uk', 'UA'), // Ukrainian
        ],
        themeMode: themeMode,
        theme: ThemeData(
          useMaterial3: _useMaterial3,
          colorSchemeSeed: _colorSchemeSeed,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF3F0FF),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: _useMaterial3,
          colorSchemeSeed: _colorSchemeSeed,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            backgroundColor: _colorSchemeSeed,
          ),
        ),
        home: Provider<MockRepository>(
          create: (_) => MockRepository(MockAPI()),
          child: MainScreen(
            useLightMode: useLightMode,
            handleBrightnessChange: handleBrightnessChange,
          ),
        ),
      );
    });
  }
}
