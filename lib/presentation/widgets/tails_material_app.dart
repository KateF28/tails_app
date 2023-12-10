import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tails_app/config/router.dart';
import 'package:tails_app/config/themes.dart';

class TailsMaterialApp extends StatefulWidget {
  const TailsMaterialApp({super.key});

  @override
  State<TailsMaterialApp> createState() => _TailsMaterialAppState();
}

class _TailsMaterialAppState extends State<TailsMaterialApp> {
  ThemeMode _themeMode = ThemeMode.system;

  bool get _useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void _handleBrightnessChange(bool useLightMode) {
    setState(() {
      _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();

    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('settings').listenable(keys: ['locale']),
      builder: (_, Box box, ___) {
        return MaterialApp.router(
          title: 'Tails App',
          locale: box.get('locale', defaultValue: const Locale('uk', 'UA')),
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
          themeMode: _themeMode,
          theme: appTheme.lightTheme,
          darkTheme: appTheme.darkTheme,
          routerConfig:
              configRouter(_useLightMode, _handleBrightnessChange, box),
          showPerformanceOverlay: false,
        );
      },
    );
  }
}
