// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedsList _$BreedsListFromJson(Map<String, dynamic> json) => BreedsList(
      breeds: (json['breeds'] as List<dynamic>?)
          ?.map((e) => Breed.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BreedsListToJson(BreedsList instance) =>
    <String, dynamic>{
      'breeds': instance.breeds,
    };
