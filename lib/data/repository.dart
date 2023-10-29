import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tails_app/data/api/mock_api.dart';
import 'package:tails_app/domain/models/breed.dart';

int _countDeletedBreeds(int value) => ++value;

class MockRepository {
  late MockAPI api;
  int _deletedBreedsCount = 0;

  MockRepository(this.api);

  Future<String?> _getBreedsFromCache() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('breedsCache');
  }

  Future<void> _cacheBreeds(List<Breed> breedsForCaching) async {
    var prefs = await SharedPreferences.getInstance();
    final String encodedData = Breed.encode(breedsForCaching);
    await prefs.setString('breedsCache', encodedData);
  }

  Future<List<Breed>> fetchBreeds() async {
    String? savedBreeds = await _getBreedsFromCache();

    if (savedBreeds == null || savedBreeds == '') {
      List<Breed> receivedBreeds = await api.getBreeds();
      await _cacheBreeds(receivedBreeds);

      return receivedBreeds;
    } else {
      List<Breed> breedsCache = Breed.decode(savedBreeds);
      return breedsCache;
    }
  }

  Future<void> addBreed(Breed addedBreed) async {
    String? prevBreedsString = await _getBreedsFromCache();
    List<Breed> cachedBreeds = Breed.decode(prevBreedsString!);
    cachedBreeds.add(addedBreed);
    await _cacheBreeds(cachedBreeds);
  }

  Future<int> deleteBreed(String id) async {
    String? prevBreedsString = await _getBreedsFromCache();
    List<Breed> filteredBreeds = Breed.decode(prevBreedsString!)
        .where((breed) => breed.id != id)
        .toList();
    await _cacheBreeds(filteredBreeds);
    int newDeletedBreedsCount =
        await compute(_countDeletedBreeds, _deletedBreedsCount);
    _deletedBreedsCount = newDeletedBreedsCount;
    return newDeletedBreedsCount;
  }

  Future<void> updateBreedStatus(String breedId, String updatedStatus) async {
    String? breedsForUpdating = await _getBreedsFromCache();
    List<Breed> filteredBreeds = Breed.decode(breedsForUpdating!).map((breed) {
      Breed newBreed = breed;
      if (breed.id == breedId) newBreed.status = updatedStatus;
      return newBreed;
    }).toList();
    await _cacheBreeds(filteredBreeds);
  }
}
