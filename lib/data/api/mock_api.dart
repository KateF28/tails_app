import 'package:uuid/uuid.dart';

import 'package:tails_app/domain/models/breed.dart';

const Uuid _uuid = Uuid();

class MockAPI {
  Future<List<Breed>> getBreeds() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Breed(
          title: 'Barbet',
          ukTitle: 'Барбет',
          imgUrl: 'images/Barbet.jpg',
          id: _uuid.v4()),
      Breed(
          title: 'Brittany',
          ukTitle: 'Бретань',
          imgUrl: 'images/Brittany.jpg',
          id: _uuid.v4()),
      Breed(
          title: 'Field Spaniel',
          ukTitle: 'Філд спаніель',
          imgUrl: 'images/Field-Spaniels.jpg',
          id: _uuid.v4()),
      Breed(
          title: 'Irish Setter',
          ukTitle: 'Ірландський сетер',
          imgUrl: 'images/Irish-Setter.jpg',
          id: _uuid.v4()),
      Breed(
          title: 'Pointer',
          ukTitle: 'Поінтер',
          imgUrl: 'images/Pointer.jpg',
          id: _uuid.v4()),
    ];
  }
}
