import 'dart:isolate';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:tails_app/domain/models/breed.dart';

Future<Box<List<Breed>>> _openBreedsHiveBox() async {
  if (!kIsWeb && !Hive.isBoxOpen('breedsBox')) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  return await Hive.openBox<List<Breed>>('breedsBox');
}

Future<void> _putBreedsIntoHiveBox(_IsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);

  final Box<List<Breed>> breedsBox = await _openBreedsHiveBox();
  await breedsBox.put("breeds", isolateData.newBreeds);
  isolateData.answerPort.send("putBreedsIntoHiveBox done");
}

class BreedsDao {
  BreedsDao();

  Future<List<Breed>?> reedBreeds() async {
    final breedsBox = await _openBreedsHiveBox();
    return breedsBox.get("breeds");
  }

  Future<void> createBreeds(List<Breed> newBreeds) async {
    final receivePort = ReceivePort();
    final RootIsolateToken rootToken = RootIsolateToken.instance!;
    final isolate = await Isolate.spawn(
      _putBreedsIntoHiveBox,
      _IsolateData(
        token: rootToken,
        newBreeds: newBreeds,
        answerPort: receivePort.sendPort,
      ),
    );

    receivePort.listen((message) {
      if (kDebugMode) print("Isolate port message: $message");
      receivePort.close();
      isolate.kill();
    });
  }
}

class _IsolateData {
  final RootIsolateToken token;
  final List<Breed> newBreeds;
  final SendPort answerPort;

  _IsolateData({
    required this.token,
    required this.newBreeds,
    required this.answerPort,
  });
}
