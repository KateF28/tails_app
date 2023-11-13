import 'package:flutter/material.dart';

import 'package:tails_app/domain/models/breed.dart';

/// This is breed details screen page/view content
class BreedView extends StatelessWidget {
  const BreedView({
    super.key,
    required this.breed,
  });

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'images/placeholder.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                Localizations.localeOf(context).languageCode == "uk"
                    ? breed.ukTitle
                    : breed.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            SliverToBoxAdapter(
              child: breed.breedGroup != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Breeds group: ${breed.breedGroup!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: breed.lifeSpan != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Lifespan: ${breed.lifeSpan!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: breed.origin != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Origin: ${breed.origin!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: breed.temperament != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Temperament: ${breed.temperament!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}
