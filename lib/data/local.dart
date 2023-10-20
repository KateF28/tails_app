import 'package:uuid/uuid.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/domain/models/breeds_group.dart';

// Breeds groups list
final List<BreedsGroup> breedsGroups = [
  BreedsGroup(
    'Sporting',
    'Спортивні',
    'Naturally active and alert, Sporting dogs make likeable, well-rounded companions. First developed to work closely with hunters to locate and/or retrieve quarry. There are four basic types of Sporting dogs: spaniels, pointers, retrievers and setters. Known for their superior instincts in water and woods, many of these breeds enjoy hunting and other field activities. Most of them require regular, invigorating exercise.',
    'Від природи активні та пильні, спортивні собаки стають приємними, всебічно розвиненими компаньйонами. Спочатку розроблено для тісної співпраці з мисливцями для пошуку здобичі. Існує чотири основних типи спортивних собак: спанієлі, пойнтери, ретривери і сетери. Відомі своїми чудовими інстинктами у воді та лісі, багато з цих порід люблять полювати. Більшість із них потребують регулярних підбадьорливих фізичних вправ.',
  ),
  BreedsGroup(
    'Hound',
    'Гончі',
    'Most hounds share the common ancestral trait of being used for hunting. Some use acute scenting powers to follow a trail. Others demonstrate a phenomenal gift of stamina as they relentlessly run down quarry. There are Pharaoh Hounds, Norwegian Elkhounds, Afghans and Beagles, among others. Some hounds share the distinct ability to produce a unique sound known as baying.',
    'Більшість гончих мають спільну родову рису — їх використовували для полювання. Деякі використовують гостру здатність відчувати запахи, щоб слідкувати за слідом. Інші демонструють феноменальний дар витривалості, невпинно біжачи по кар’єру. Серед інших є фараонові собаки, норвезькі елькхаунди, афганці та біглі. Деякі собаки мають особливу здатність видавати унікальний звук, відомий як лай.',
  ),
];

// Breeds examples of each breeds group
const Uuid _uuid = Uuid();

final List<Breed> sportingBreeds = [
  Breed('Barbet', 'Барбет', 'images/Barbet.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Brittany', 'Бретань', 'images/Brittany.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Field Spaniel', 'Філд спаніель', 'images/Field-Spaniels.jpg',
      DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Irish Setter', 'Ірландський сетер', 'images/Irish-Setter.jpg',
      DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Pointer', 'Поінтер', 'images/Pointer.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
];

final List<Breed> houndBreeds = [
  Breed('Pharaoh Hound', 'Фараонова гонча', 'images/Pharaoh-Hound.jpg',
      DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Norwegian Elkhound', 'Норвезький елькхаунд',
      'images/Norwegian-Elkhound.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Rhodesian Ridgeback', 'Родезійський риджбек',
      'images/Rhodesian-Ridgeback.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Saluki', 'Салюки', 'images/Saluki.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Sloughi', 'Слаугі', 'images/Sloughi.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
];
