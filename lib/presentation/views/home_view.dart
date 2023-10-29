import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/presentation/widgets/breeds_list.dart';

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  final List<Breed> breeds;

  const HomeView({super.key, required this.breeds});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _deletedBreedsCount = 0;

  void _countRemovedBreeds(int deletedBreedsCount) {
    setState(() {
      _deletedBreedsCount = deletedBreedsCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                AppLocalizations.of(context)!
                    .deletedBreedsCount(_deletedBreedsCount.toString()),
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
            BreedsList(countRemovedBreeds: _countRemovedBreeds),
          ],
        );
      },
    );
  }
}
