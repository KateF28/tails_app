// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageAttributes.dart';

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
