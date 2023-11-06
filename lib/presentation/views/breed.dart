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
                    breed.imgUrl,
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
                    : breed.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
