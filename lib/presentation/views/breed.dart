import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: breed.image?.url == null
                      ? Image.asset(
                          'images/placeholder.jpg',
                          fit: BoxFit.cover,
                          height: 150,
                        )
                      : CachedNetworkImage(
                          imageUrl: breed.image!.url!,
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
              child: breed.breedGroup == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Text(
                        '${appLocalizations.breedsGroup}: ${breed.breedGroup!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
            ),
            SliverToBoxAdapter(
              child: breed.lifeSpan == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${appLocalizations.lifeSpan}: ${breed.lifeSpan!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
            ),
            SliverToBoxAdapter(
              child: breed.origin == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${appLocalizations.origin}: ${breed.origin}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
            ),
            SliverToBoxAdapter(
              child: breed.temperament == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: Text(
                        '${appLocalizations.temperament}: ${breed.temperament!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
