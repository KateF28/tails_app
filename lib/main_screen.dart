import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:tails_app/presentation/views/home_view.dart';
import 'package:tails_app/domain/models/breeds_group.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

/// Main screen with appBar, FAB, BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<BreedsGroup> _breedsGroups = [
    BreedsGroup('Sporting Group',
        'Naturally active and alert, Sporting dogs make likeable, well-rounded companions. First developed to work closely with hunters to locate and/or retrieve quarry. There are four basic types of Sporting dogs; spaniels, pointers, retrievers and setters. Known for their superior instincts in water and woods, many of these breeds enjoy hunting and other field activities. Most of them require regular, invigorating exercise.'),
    BreedsGroup('Hound Group',
        'Most hounds share the common ancestral trait of being used for hunting. Some use acute scenting powers to follow a trail. Others demonstrate a phenomenal gift of stamina as they relentlessly run down quarry. There are Pharaoh Hounds, Norwegian Elkhounds, Afghans and Beagles, among others. Some hounds share the distinct ability to produce a unique sound known as baying.'),
  ];
  static const Uuid _uuid = Uuid();
  final List<Breed> _sportingBreeds = [
    Breed('Barbet', 'images/Barbet.jpg', DateTime(2023, 10, 12), _uuid.v4()),
    Breed(
        'Brittany', 'images/Brittany.jpg', DateTime(2023, 10, 12), _uuid.v4()),
    Breed('Field Spaniel', 'images/Field-Spaniels.jpg', DateTime(2023, 10, 12),
        _uuid.v4()),
    Breed('Irish Setter', 'images/Irish-Setter.jpg', DateTime(2023, 10, 12),
        _uuid.v4()),
    Breed('Pointer', 'images/Pointer.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  ];
  final List<Breed> _houndBreeds = [
    Breed('Pharaoh Hound', 'images/Pharaoh-Hound.jpg', DateTime(2023, 10, 12),
        _uuid.v4()),
    Breed('Norwegian Elkhound', 'images/Norwegian-Elkhound.jpg',
        DateTime(2023, 10, 12), _uuid.v4()),
    Breed('Rhodesian Ridgeback', 'images/Rhodesian-Ridgeback.jpg',
        DateTime(2023, 10, 12), _uuid.v4()),
    Breed('Saluki', 'images/Saluki.jpg', DateTime(2023, 10, 12), _uuid.v4()),
    Breed('Sloughi', 'images/Sloughi.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  ];

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
                _breedsGroups[_selectedIndex].description,
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
      HomeView(breeds: _sportingBreeds),
      HomeView(breeds: _houndBreeds),
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
                        _breedsGroups[0].title,
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
                        _breedsGroups[1].title,
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
