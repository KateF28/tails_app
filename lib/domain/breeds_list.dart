import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tails_app/domain/models/breed.dart';

class BreedsList extends Notifier<List<Breed>> {
  @override
  List<Breed> build() {
    return [];
  }

  void deleteBreed(String id) {
    state = [...state.where((breed) => breed.id != id).toList()];
  }

  void addBreeds(List<Breed> newBreeds) {
    state = [...state, ...newBreeds];
  }

  void addBreed(Breed newBreed) {
    state = [...state, newBreed];
  }

  void updateBreedStatus(String breedId, String updatedStatus) {
    state = [
      ...state.map((breed) {
        if (breed.id == breedId) breed.status = updatedStatus;
        return breed;
      }).toList()
    ];
  }
}

final breedsProvider = NotifierProvider<BreedsList, List<Breed>>(
  () => BreedsList(),
);
