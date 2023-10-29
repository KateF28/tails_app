import 'package:uuid/uuid.dart';

import 'package:tails_app/domain/models/breed.dart';

const Uuid _uuid = Uuid();

class MockAPI {
  Future<List<Breed>> getBreeds() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Breed(
          id: _uuid.v4(),
          title: 'Barbet',
          ukTitle: 'Барбет',
          imgUrl: 'images/Barbet.jpg'),
      Breed(
          id: _uuid.v4(),
          title: 'Brittany',
          ukTitle: 'Бретань',
          imgUrl: 'images/Brittany.jpg'),
      Breed(
          id: _uuid.v4(),
          title: 'Field Spaniel',
          ukTitle: 'Філд спаніель',
          imgUrl: 'images/Field-Spaniels.jpg'),
      Breed(
          id: _uuid.v4(),
          title: 'Irish Setter',
          ukTitle: 'Ірландський сетер',
          imgUrl: 'images/Irish-Setter.jpg'),
      Breed(
          id: _uuid.v4(),
          title: 'Pointer',
          ukTitle: 'Поінтер',
          imgUrl: 'images/Pointer.jpg'),
    ];
  }
}
