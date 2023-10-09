import 'package:flutter/material.dart';
import 'package:tails_app/presentation/views/home_view.dart';
import 'package:tails_app/utils/constants.dart';

/// Main screen with appBar, FAB, BottomNavigationBar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isListView = true;

  void _onFABPressed() {
    setState(() {
      _isListView = !_isListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tails App')),
      ),
      body: HomeView(
        isListView: _isListView,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFABPressed,
        tooltip: 'Change view',
        child: _isListView
            ? const Icon(Icons.view_module)
            : const Icon(Icons.format_list_bulleted),
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
