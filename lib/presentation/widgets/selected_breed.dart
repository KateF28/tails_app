// Core:
import 'package:flutter/material.dart';
// Models:
import 'package:tails_app/domain/models/breed.dart';

/// This is main screen widget for the selected breed displaying
class SelectedBreedWidget extends StatelessWidget {
  final Breed breed;
  const SelectedBreedWidget({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
          child: Center(
              child: Text(breed.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0)))),
      SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Image.asset(
              breed.imgUrl,
              fit: BoxFit.contain,
              height: 150,
            ),
          ),
        ),
      )
    ]);
  }
}
