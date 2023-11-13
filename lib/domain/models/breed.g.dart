// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breed _$BreedFromJson(Map<String, dynamic> json) => Breed(
      id: const _Converter().fromJson(json['id'] as int),
      name: json['name'] as String,
      ukTitle: json['ukTitle'] as String? ?? "",
      image: json['image'] == null
          ? null
          : ImageAttributes.fromJson(json['image'] as Map<String, dynamic>),
      status: json['status'] as String? ?? 'initial',
      referenceImageId: json['reference_image_id'] as String?,
      breedGroup: json['breed_group'] as String?,
      breedFor: json['bred_for'] as String?,
      lifeSpan: json['life_span'] as String?,
      origin: json['origin'] as String?,
      temperament: json['temperament'] as String?,
      weight: json['weight'] == null
          ? null
          : Metrics.fromJson(json['weight'] as Map<String, dynamic>),
      height: json['height'] == null
          ? null
          : Metrics.fromJson(json['height'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BreedToJson(Breed instance) => <String, dynamic>{
      'id': const _Converter().toJson(instance.id),
      'name': instance.name,
      'ukTitle': instance.ukTitle,
      'image': instance.image,
      'status': instance.status,
      'reference_image_id': instance.referenceImageId,
      'breed_group': instance.breedGroup,
      'bred_for': instance.breedFor,
      'life_span': instance.lifeSpan,
      'origin': instance.origin,
      'temperament': instance.temperament,
      'weight': instance.weight,
      'height': instance.height,
    };
