import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tails_app/presentation/views/breed.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/models/breed.dart';

/// Breed details screen with AppBar, BottomNavigationBar
class BreedScreen extends StatefulWidget {
  const BreedScreen({
    super.key,
    required this.breedId,
  });

  final String breedId;

  @override
  State<BreedScreen> createState() => _BreedScreenState();
}

class _BreedScreenState extends State<BreedScreen> {
  int _selectedBottomNavigationBarItemIndex = 0;

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
        context.go('/menu');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<BreedsListBloc, BreedsListState>(
      builder: (context, state) {
        final breedsListState =
            context.read<BreedsListBloc>().state as BreedsListLoaded;
        final Breed breed = breedsListState.breeds.firstWhere(
          (element) => element.id == widget.breedId,
        );

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(
              Localizations.localeOf(context).languageCode == "uk"
                  ? breed.ukTitle
                  : breed.title,
              style: GoogleFonts.roboto(
                textStyle: textTheme.titleLarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BreedView(breed: breed),
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
      },
    );
  }
}
