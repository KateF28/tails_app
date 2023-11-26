// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedAdapter extends TypeAdapter<Breed> {
  @override
  final int typeId = 1;

  @override
  Breed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breed(
      id: fields[0] as String,
      name: fields[1] as String,
      ukTitle: fields[2] == null ? '' : fields[2] as String,
      image: fields[3] as ImageAttributes?,
      status: fields[4] == null ? 'initial' : fields[4] as String,
      referenceImageId: fields[5] as String?,
      breedGroup: fields[6] as String?,
      breedFor: fields[7] as String?,
      lifeSpan: fields[8] as String?,
      origin: fields[9] as String?,
      temperament: fields[10] as String?,
      weight: fields[11] as Metrics?,
      height: fields[12] as Metrics?,
    );
  }

  @override
  void write(BinaryWriter writer, Breed obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ukTitle)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.referenceImageId)
      ..writeByte(6)
      ..write(obj.breedGroup)
      ..writeByte(7)
      ..write(obj.breedFor)
      ..writeByte(8)
      ..write(obj.lifeSpan)
      ..writeByte(9)
      ..write(obj.origin)
      ..writeByte(10)
      ..write(obj.temperament)
      ..writeByte(11)
      ..write(obj.weight)
      ..writeByte(12)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
