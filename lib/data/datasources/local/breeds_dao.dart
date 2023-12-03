import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:tails_app/domain/models/breed.dart';

Future<Box> _openBreedsHiveBox() async {
  if (!kIsWeb && !Hive.isBoxOpen('breedsBox')) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  return await Hive.openBox('breedsBox');
}

class BreedsDao {
  BreedsDao();

  Future<List<Breed>> reedBreeds() async {
    final breedsBox = await _openBreedsHiveBox();
    final result = breedsBox.get("breeds", defaultValue: []) ?? [];

    return List<Breed>.from(result);
  }

  Future<void> createBreeds(List<Breed> newBreeds) async {
    final breedsBox = await _openBreedsHiveBox();
    await breedsBox.put("breeds", newBreeds);
  }
}
