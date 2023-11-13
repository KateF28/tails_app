import 'package:json_annotation/json_annotation.dart';

part 'metrics.g.dart';

@JsonSerializable()
class Metrics {
  final String? imperial;
  final String? metric;

  Metrics({
    this.imperial,
    this.metric,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) =>
      _$MetricsFromJson(json);
  Map<String, dynamic> toJson() => _$MetricsToJson(this);
}
