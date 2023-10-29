import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tails_app/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  /*
  To Change Locale of the App
   */
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocale.languageCode);
    prefs.setString('countryCode', newLocale.countryCode ?? '');

    state?.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('uk', 'UA');
  final bool _useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  static const _colorSchemeSeed = Color(0xFF7950f2);

  @override
  void initState() {
    super.initState();
    _removeBreedsCache();
    _fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
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

  // Clean up the breedsCache value of shared preferences when the app is launched
  void _removeBreedsCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('breedsCache', '');
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

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tails App',
      locale: _locale,
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
          )),
      home: MainScreen(
        useLightMode: useLightMode,
        handleBrightnessChange: handleBrightnessChange,
      ),
    );
  }
}
