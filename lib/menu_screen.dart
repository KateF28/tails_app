import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tails_app/presentation/views/menu.dart';

/// Menu screen with appBar, BottomNavigationBar
class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedBottomNavigationBarItemIndex = 2;

  /// Navigate to another page
  void _onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _selectedBottomNavigationBarItemIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/search');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Tails App',
          style: GoogleFonts.roboto(
            textStyle: textTheme.titleLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/menu/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const MenuView(),
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
            tooltip: 'Go to home page',
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
