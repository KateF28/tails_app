import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/presentation/views/home_view.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/data/datasources/local/breeds.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/feature/locale/bloc/locale_bloc.dart';

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
  int _selectedDrawerTileIndex = 0;
  Breed _chosenDropdownValue = breedsForAdding.first;
  final List<Breed> _breedsForAdding = breedsForAdding;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedDrawerTileIndex = index;
    });
  }

  // Add breed to the page breeds list and cache them, remove an added breed from dropdown options
  void _onBreedAddingDialogClosed() {
    context.read<BreedsListBloc>().add(AddBreedEvent(_chosenDropdownValue));

    setState(() {
      _breedsForAdding.remove(_chosenDropdownValue);
      if (_breedsForAdding.isNotEmpty) {
        _chosenDropdownValue = _breedsForAdding.first;
      }
    });
  }

  // Open dialog for adding a new breed
  void _onFABPressed() {
    showGeneralDialog(
      context: context,
      barrierColor: dialogBgColor,
      barrierDismissible: true,
      barrierLabel: 'Adding a breed dialog',
      transitionDuration: transitionDuration,
      pageBuilder: (_, __, ___) {
        return Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: whiteColor,
                size: 40.0,
              ),
              tooltip: 'Add breed and close dialog',
              onPressed: () {
                _onBreedAddingDialogClosed();
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 70.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        AppLocalizations.of(context)!.addBreed,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          decoration: TextDecoration.none,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    _buildNewBreedDropdown(context),
                  ],
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.read<LocaleBloc>().add(
                                  ChangeLocaleEvent(const Locale("en", "")));
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
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<LocaleBloc>().add(
                                  ChangeLocaleEvent(const Locale("uk", "UA")));
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
                                  color: textColor,
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
      floatingActionButton: _breedsForAdding.isEmpty
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: _onFABPressed,
              tooltip: 'Open dialog for adding a breed',
              child: const Icon(Icons.add),
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

  /// The function returns DropDown for a new breed selection
  Widget _buildNewBreedDropdown(ctx) => DropdownButtonFormField<String>(
        value: _chosenDropdownValue.title,
        icon: const Icon(Icons.arrow_downward, color: whiteColor),
        elevation: 16,
        style: Theme.of(ctx).textTheme.bodyLarge!.copyWith(
              color: textColor,
            ),
        onChanged: (String? value) {
          setState(() {
            _chosenDropdownValue =
                breedsForAdding.firstWhere((breed) => breed.title == value!);
          });
        },
        items: breedsForAdding.map<DropdownMenuItem<String>>((Breed value) {
          return DropdownMenuItem<String>(
            value: value.title,
            child: Text(Localizations.localeOf(ctx).languageCode == "uk"
                ? value.ukTitle
                : value.title),
          );
        }).toList(),
      );
}
