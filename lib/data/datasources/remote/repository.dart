import 'dart:async';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/data/datasources/remote/dogs_api.dart';

class Repository {
  final DogsApi _dogsApi;

  Repository(this._dogsApi);

  Future<List<Breed>> fetchBreeds() async => await _dogsApi.getBreeds();
}
