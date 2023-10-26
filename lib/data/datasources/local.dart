import 'package:uuid/uuid.dart';

import 'package:tails_app/domain/models/breed.dart';

// Breeds list for adding a breed DropDown
const Uuid _uuid = Uuid();

final List<Breed> breedsForAdding = [
  Breed(
      title: 'Pharaoh Hound',
      ukTitle: 'Фараонова гонча',
      imgUrl: 'images/Pharaoh-Hound.jpg',
      id: _uuid.v4()),
  Breed(
      title: 'Norwegian Elkhound',
      ukTitle: 'Норвезький елькхаунд',
      imgUrl: 'images/Norwegian-Elkhound.jpg',
      id: _uuid.v4()),
  Breed(
      title: 'Rhodesian Ridgeback',
      ukTitle: 'Родезійський риджбек',
      imgUrl: 'images/Rhodesian-Ridgeback.jpg',
      id: _uuid.v4()),
  Breed(
      title: 'Saluki',
      ukTitle: 'Салюки',
      imgUrl: 'images/Saluki.jpg',
      id: _uuid.v4()),
  Breed(
      title: 'Sloughi',
      ukTitle: 'Слаугі',
      imgUrl: 'images/Sloughi.jpg',
      id: _uuid.v4()),
];
