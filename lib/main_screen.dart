import 'package:flutter/material.dart';
import 'package:tails_app/presentation/views/home_view.dart';
import 'package:tails_app/utils/constants.dart';
import 'data/local.dart';

/// Main screen with appBar, FAB, BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
                breedsGroups[_selectedIndex].description,
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tails App'),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: bgColor,
                      ),
                      child: Text(
                        'Breeds groups',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        breedsGroups[0].title,
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
                        breedsGroups[1].title,
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
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text('Breeds groups'),
                    Text('Ukraine'),
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
        backgroundColor: whiteColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '',
            tooltip: 'Add a dog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
