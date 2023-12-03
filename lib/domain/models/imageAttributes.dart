import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imageAttributes.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class ImageAttributes extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int? height;
  @HiveField(2)
  final int? width;
  @HiveField(3)
  final String? url;

  ImageAttributes({
    required this.id,
    this.height,
    this.width,
    this.url,
  });

  factory ImageAttributes.fromJson(Map<String, dynamic> json) =>
      _$ImageAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ImageAttributesToJson(this);
}
