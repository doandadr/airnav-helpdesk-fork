// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pipeline _$PipelineFromJson(Map<String, dynamic> json) =>
    Pipeline(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$PipelineToJson(Pipeline instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
