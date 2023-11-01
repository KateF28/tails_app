import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/data/repository.dart';

class BreedsList extends Notifier<List<Breed>> {
  @override
  List<Breed> build() {
    return [];
  }

  Future<void> addInitialBreeds() async {
    MockRepository repository = ref.watch(repositoryProvider);
    List<Breed> initialBreeds = await repository.fetchBreeds();
    state = initialBreeds;
  }

  void addBreed(Breed newBreed) {
    state = [...state, newBreed];
  }

  void deleteBreed(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateBreedStatus(String breedId, String updatedStatus) {
    state = state.map((breed) {
      if (breed.id == breedId) breed.status = updatedStatus;
      return breed;
    }).toList();
  }
}

final breedsProvider =
    NotifierProvider<BreedsList, List<Breed>>(BreedsList.new);
