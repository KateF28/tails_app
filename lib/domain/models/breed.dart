import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'imageAttributes.dart';
import 'metrics.dart';

part 'breed.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Breed extends HiveObject {
  @_Converter()
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2, defaultValue: '')
  final String ukTitle;
  @HiveField(3)
  final ImageAttributes? image;
  @HiveField(4, defaultValue: 'initial')
  String status;

  @JsonKey(name: 'reference_image_id')
  @HiveField(5)
  final String? referenceImageId;

  @JsonKey(name: 'breed_group')
  @HiveField(6)
  final String? breedGroup;

  @JsonKey(name: 'bred_for')
  @HiveField(7)
  final String? breedFor;

  @JsonKey(name: 'life_span')
  @HiveField(8)
  final String? lifeSpan;

  @HiveField(9)
  final String? origin;
  @HiveField(10)
  final String? temperament;
  @HiveField(11)
  final Metrics? weight;
  @HiveField(12)
  final Metrics? height;

  Breed({
    required this.id,
    required this.name,
    this.ukTitle = "",
    this.image,
    this.status = 'initial',
    this.referenceImageId,
    this.breedGroup,
    this.breedFor,
    this.lifeSpan,
    this.origin,
    this.temperament,
    this.weight,
    this.height,
  });

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
  Map<String, dynamic> toJson() => _$BreedToJson(this);
}

class _Converter implements JsonConverter<String, int> {
  const _Converter();

  @override
  String fromJson(int json) => json.toString();

  @override
  int toJson(String stringifiedId) => int.parse(stringifiedId);
}

// A breed from response example:
// bred_for: "Small rodent hunting, lapdog"
// breed_group: "Toy"
// height: {imperial: "9 - 11.5", metric: "23 - 29"}
// image: {id: "BJa4kxc4X", width: 1600, height: 1199, url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"}
// life_span: "10 - 12 years"
// origin: "Germany, France"
// reference_image_id: "BJa4kxc4X"
// temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving"
// weight: {imperial: "6 - 13", metric: "3 - 6"}
// id: 1
