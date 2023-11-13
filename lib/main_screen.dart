import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tails_app/presentation/views/home.dart';
import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';

/// Main screen with appBar, Drawer, FAB, BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.useLightMode,
    required this.handleBrightnessChange,
    required this.hiveBox,
  });

  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;
  final Box hiveBox;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedDrawerTileIndex = 0;
  int _selectedBottomNavigationBarItemIndex = 1;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedDrawerTileIndex = index;
    });
  }

  /// Navigate to another page or open dialog for a breed adding if possible
  void _onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _selectedBottomNavigationBarItemIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/search');
        break;
      case 1:
        break;
      case 2:
        context.go('/menu');
        break;
    }
  }

  // Request breeds again
  void _onFABPressed() {
    context.read<BreedsListBloc>().add(RequestBreedsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    String appCurrentLanguageCode =
        Localizations.localeOf(context).languageCode;
    final textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              widget.hiveBox
                                  .put('locale', const Locale("en", ""));
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(40, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.center),
                            child: Opacity(
                              opacity:
                                  appCurrentLanguageCode == 'uk' ? 0.5 : 1.0,
                              child: const Text(
                                'EN',
                                style: TextStyle(
                                  color: Environment.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.hiveBox
                                  .put('locale', const Locale("uk", "UA"));
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(40, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.center),
                            child: Opacity(
                              opacity:
                                  appCurrentLanguageCode == 'en' ? 0.5 : 1.0,
                              child: const Text(
                                'УК',
                                style: TextStyle(
                                  color: Environment.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        appLocalizations!.breeds,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedDrawerTileIndex == 0,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _onDrawerItemTapped(0);
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
      body: const HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFABPressed,
        tooltip: 'Request breeds once more',
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavigationBarItemIndex,
        onTap: _onBottomNavigationBarItemTapped,
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
            tooltip: 'Add a dog if possible',
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
