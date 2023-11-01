import 'package:flutter/foundation.dart';

import 'package:tails_app/data/api/mock_api.dart';
import 'package:tails_app/domain/models/breed.dart';

int _countDeletedBreeds(int value) => ++value;

class MockRepository {
  final MockAPI _mockApi;
  int _deletedBreedsCount = 0;

  MockRepository(this._mockApi);

  Future<List<Breed>> fetchBreeds() async => await _mockApi.getBreeds();

  Future<int> computeDeletedBreedsCount() async {
    int newDeletedBreedsCount =
        await compute(_countDeletedBreeds, _deletedBreedsCount);
    _deletedBreedsCount = newDeletedBreedsCount;
    return newDeletedBreedsCount;
  }
}
