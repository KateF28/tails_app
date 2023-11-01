import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/data/repository.dart';

class BreedsList extends AsyncNotifier<List<Breed>> {
  @override
  FutureOr<List<Breed>> build() async {
    state = const AsyncValue.loading();
    MockRepository repository = ref.watch(repositoryProvider);
    return await repository.fetchBreeds();
  }

  Future<void> addBreed(Breed newBreed) async {
    state = await AsyncValue.guard(() async {
      return await state.map(
        data: (AsyncData<List<Breed>> data) => [...data.value, newBreed],
        error: (AsyncError<List<Breed>> error) => [],
        loading: (AsyncLoading<List<Breed>> loading) => [],
      );
    });
  }

  Future<void> deleteBreed(String id) async {
    state = await AsyncValue.guard(() async {
      return await state.map(
        data: (AsyncData<List<Breed>> data) =>
            [...data.value.where((breed) => breed.id != id).toList()],
        error: (AsyncError<List<Breed>> error) => [],
        loading: (AsyncLoading<List<Breed>> loading) => [],
      );
    });
  }

  Future<void> updateBreedStatus(String breedId, String updatedStatus) async {
    state = await AsyncValue.guard(() async {
      return await state.map(
        data: (AsyncData<List<Breed>> data) => [
          ...data.value.map((breed) {
            if (breed.id == breedId) breed.status = updatedStatus;
            return breed;
          }).toList()
        ],
        error: (AsyncError<List<Breed>> error) => [],
        loading: (AsyncLoading<List<Breed>> loading) => [],
      );
    });
  }
}

final breedsProvider = AsyncNotifierProvider<BreedsList, List<Breed>>(
  () => BreedsList(),
);
