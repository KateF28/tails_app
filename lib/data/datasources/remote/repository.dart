import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/data/datasources/remote/dogs_api.dart';

int _countDeletedBreeds(int value) => ++value;

class Repository {
  final DogsApi _dogsApi;
  int _deletedBreedsCount = 0;

  Repository(this._dogsApi);

  Future<List<Breed>> fetchBreeds() async => await _dogsApi.getBreeds();

  Future<int> computeDeletedBreedsCount() async {
    int newDeletedBreedsCount =
        await compute(_countDeletedBreeds, _deletedBreedsCount);
    _deletedBreedsCount = newDeletedBreedsCount;
    return newDeletedBreedsCount;
  }
}
