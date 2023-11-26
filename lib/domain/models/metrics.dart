import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metrics.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Metrics extends HiveObject {
  @HiveField(0)
  final String? imperial;
  @HiveField(1)
  final String? metric;

  Metrics({
    this.imperial,
    this.metric,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) =>
      _$MetricsFromJson(json);
  Map<String, dynamic> toJson() => _$MetricsToJson(this);
}
