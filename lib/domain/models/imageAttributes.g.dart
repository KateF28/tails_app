// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageAttributes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageAttributesAdapter extends TypeAdapter<ImageAttributes> {
  @override
  final int typeId = 2;

  @override
  ImageAttributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageAttributes(
      id: fields[0] as String,
      height: fields[1] as int?,
      width: fields[2] as int?,
      url: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageAttributes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageAttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageAttributes _$ImageAttributesFromJson(Map<String, dynamic> json) =>
    ImageAttributes(
      id: json['id'] as String,
      height: json['height'] as int?,
      width: json['width'] as int?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ImageAttributesToJson(ImageAttributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
    };
