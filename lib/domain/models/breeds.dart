import 'package:json_annotation/json_annotation.dart';
import 'breed.dart';

part 'breeds.g.dart';

@JsonSerializable()
class BreedsList {
  final List<Breed>? breeds;
  BreedsList({this.breeds});
  factory BreedsList.fromJson(json) => _$BreedsListFromJson({'breeds': json});
  List toJson() => _$BreedsListToJson(this)['breeds'];
}
