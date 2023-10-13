import 'package:uuid/uuid.dart';
import '../domain/models/breed.dart';
import '../domain/models/breeds_group.dart';

// Breeds groups list
final List<BreedsGroup> breedsGroups = [
  BreedsGroup('Sporting Group',
      'Naturally active and alert, Sporting dogs make likeable, well-rounded companions. First developed to work closely with hunters to locate and/or retrieve quarry. There are four basic types of Sporting dogs; spaniels, pointers, retrievers and setters. Known for their superior instincts in water and woods, many of these breeds enjoy hunting and other field activities. Most of them require regular, invigorating exercise.'),
  BreedsGroup('Hound Group',
      'Most hounds share the common ancestral trait of being used for hunting. Some use acute scenting powers to follow a trail. Others demonstrate a phenomenal gift of stamina as they relentlessly run down quarry. There are Pharaoh Hounds, Norwegian Elkhounds, Afghans and Beagles, among others. Some hounds share the distinct ability to produce a unique sound known as baying.'),
];

// Breeds examples of each breeds group
const Uuid _uuid = Uuid();

final List<Breed> sportingBreeds = [
  Breed('Barbet', 'images/Barbet.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Brittany', 'images/Brittany.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Field Spaniel', 'images/Field-Spaniels.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Irish Setter', 'images/Irish-Setter.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Pointer', 'images/Pointer.jpg', DateTime(2023, 10, 12), _uuid.v4()),
];

final List<Breed> houndBreeds = [
  Breed('Pharaoh Hound', 'images/Pharaoh-Hound.jpg', DateTime(2023, 10, 12),
      _uuid.v4()),
  Breed('Norwegian Elkhound', 'images/Norwegian-Elkhound.jpg',
      DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Rhodesian Ridgeback', 'images/Rhodesian-Ridgeback.jpg',
      DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Saluki', 'images/Saluki.jpg', DateTime(2023, 10, 12), _uuid.v4()),
  Breed('Sloughi', 'images/Sloughi.jpg', DateTime(2023, 10, 12), _uuid.v4()),
];
