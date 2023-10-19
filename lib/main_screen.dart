import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tails_app/presentation/views/home_view.dart';
import 'package:tails_app/main.dart';
import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/data/local.dart';

/// Main screen with appBar, Drawer, FAB, BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.useLightMode,
    required this.handleBrightnessChange,
  });

  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFABPressed() {
    showGeneralDialog(
      context: context,
      barrierColor: dialogBgColor,
      barrierDismissible: false,
      barrierLabel: 'Breeds group information dialog',
      transitionDuration: transitionDuration,
      pageBuilder: (_, __, ___) {
        return Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.close,
                color: whiteColor,
                size: 40.0,
              ),
              tooltip: 'Close dialog',
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 70.0),
              child: Text(
                Localizations.localeOf(context).languageCode == 'uk'
                    ? breedsGroups[_selectedIndex].ukDescription
                    : breedsGroups[_selectedIndex].description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomeView(breeds: sportingBreeds),
      HomeView(breeds: houndBreeds),
    ];
    String appCurrentLanguageCode =
        Localizations.localeOf(context).languageCode;
    final textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tails App',
          style: GoogleFonts.roboto(
            textStyle: textTheme.titleLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations!.breedsGroups,
                            style: GoogleFonts.roboto(
                              textStyle: textTheme.titleLarge!.copyWith(
                                color: textColor,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    MyApp.setLocale(
                                        context, const Locale("en", ""));
                                  });
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(40, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.center),
                                child: Opacity(
                                  opacity: appCurrentLanguageCode == 'uk'
                                      ? 0.5
                                      : 1.0,
                                  child: const Text(
                                    'EN',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    MyApp.setLocale(
                                      context,
                                      const Locale("uk", "UA"),
                                    );
                                  });
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(40, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.center),
                                child: Opacity(
                                  opacity: appCurrentLanguageCode == 'en'
                                      ? 0.5
                                      : 1.0,
                                  child: const Text(
                                    'УК',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        appCurrentLanguageCode == 'uk'
                            ? breedsGroups[0].ukTitle
                            : breedsGroups[0].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedIndex == 0,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _onDrawerItemTapped(0);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        appCurrentLanguageCode == 'uk'
                            ? breedsGroups[1].ukTitle
                            : breedsGroups[1].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedIndex == 1,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _onDrawerItemTapped(1);
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17.0, 30.0, 19.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.lightTheme,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Switch(
                              value: widget.useLightMode,
                              onChanged: (value) {
                                widget.handleBrightnessChange(value);
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      appLocalizations.dogsBreedGroups,
                      style: GoogleFonts.merriweather(),
                    ),
                    Text(
                      appLocalizations.ukraine,
                      style: GoogleFonts.merriweather(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: widgetOptions[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _onFABPressed,
        tooltip: 'Show selected breeds group information',
        child: const Icon(Icons.info_outline_rounded),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showSelectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 40),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: appLocalizations.search,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '',
            tooltip: 'Add a dog',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.grid_view),
            label: appLocalizations.menu,
          ),
        ],
      ),
    );
  }
}
