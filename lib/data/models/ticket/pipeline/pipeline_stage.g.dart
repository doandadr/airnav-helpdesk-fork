// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PipelineStage _$PipelineStageFromJson(Map<String, dynamic> json) =>
    PipelineStage(
      id: (json['id'] as num).toInt(),
      pipeline: Pipeline.fromJson(json['pipeline'] as Map<String, dynamic>),
      stage: json['stage'] as String,
      percentage: json['percentage'] as String,
      pic: json['pic'] as String?,
      picGroup: json['pic_group'] == null
          ? null
          : PicGroup.fromJson(json['pic_group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PipelineStageToJson(PipelineStage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pipeline': instance.pipeline,
      'stage': instance.stage,
      'percentage': instance.percentage,
      'pic': instance.pic,
      'pic_group': instance.picGroup,
    };
