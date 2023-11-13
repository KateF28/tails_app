import 'package:json_annotation/json_annotation.dart';

part 'imageAttributes.g.dart';

@JsonSerializable()
class ImageAttributes {
  final String id;
  final int? height;
  final int? width;
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
