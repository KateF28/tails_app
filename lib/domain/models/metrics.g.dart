// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metrics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetricsAdapter extends TypeAdapter<Metrics> {
  @override
  final int typeId = 3;

  @override
  Metrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metrics(
      imperial: fields[0] as String?,
      metric: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Metrics obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imperial)
      ..writeByte(1)
      ..write(obj.metric);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Metrics _$MetricsFromJson(Map<String, dynamic> json) => Metrics(
      imperial: json['imperial'] as String?,
      metric: json['metric'] as String?,
    );

Map<String, dynamic> _$MetricsToJson(Metrics instance) => <String, dynamic>{
      'imperial': instance.imperial,
      'metric': instance.metric,
    };
