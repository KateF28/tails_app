import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/domain/models/breeds.dart';

class DogsApi {
  final Dio _client;

  DogsApi()
      : _client = Dio(BaseOptions(
          baseUrl: Environment.host,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': Environment.apiKey
          },
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ));

  Future<List<Breed>> getBreeds() async {
    try {
      final Response response = await _client.get(Environment.breeds,
          queryParameters: {'limit': 25, 'page': 0, 'size': "small"});

      if (response.statusCode == 200 && response.data != null) {
        BreedsList breedsList = BreedsList.fromJson(response.data);
        return breedsList.breeds ?? [];
      } else {
        throw Exception('Failed to fetch feed');
      }
    } on DioException catch (e) {
      if (kDebugMode) print('Failed to fetch breeds. ${e.message ?? ''}');
      throw Exception('Failed to fetch breeds. ${e.message ?? ''}');
    }
  }
}
