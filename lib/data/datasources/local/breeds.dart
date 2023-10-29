import 'package:uuid/uuid.dart';

import 'package:tails_app/domain/models/breed.dart';

// Breeds list for adding a breed DropDown
const Uuid _uuid = Uuid();

final List<Breed> breedsForAdding = [
  Breed(
      id: _uuid.v4(),
      title: 'Pharaoh Hound',
      ukTitle: 'Фараонова гонча',
      imgUrl: 'images/Pharaoh-Hound.jpg'),
  Breed(
      id: _uuid.v4(),
      title: 'Norwegian Elkhound',
      ukTitle: 'Норвезький елькхаунд',
      imgUrl: 'images/Norwegian-Elkhound.jpg'),
  Breed(
      id: _uuid.v4(),
      title: 'Rhodesian Ridgeback',
      ukTitle: 'Родезійський риджбек',
      imgUrl: 'images/Rhodesian-Ridgeback.jpg'),
  Breed(
      id: _uuid.v4(),
      title: 'Saluki',
      ukTitle: 'Салюки',
      imgUrl: 'images/Saluki.jpg'),
  Breed(
      id: _uuid.v4(),
      title: 'Sloughi',
      ukTitle: 'Слаугі',
      imgUrl: 'images/Sloughi.jpg'),
];
