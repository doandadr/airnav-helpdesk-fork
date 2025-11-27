import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'pipeline.dart';
import 'pic_group.dart';

part 'pipeline_stage.g.dart';

@JsonSerializable()
class PipelineStage extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'pipeline')
  final Pipeline pipeline;
  @JsonKey(name: 'stage')
  final String stage; // new, assigned, in progress, done
  @JsonKey(name: 'percentage')
  final String percentage;
  @JsonKey(name: 'pic')
  final String? pic;
  @JsonKey(name: 'pic_group')
  final PicGroup? picGroup;

  const PipelineStage({
    required this.id,
    required this.pipeline,
    required this.stage,
    required this.percentage,
    this.pic,
    this.picGroup,
  });

  factory PipelineStage.fromJson(Map<String, dynamic> json) =>
      _$PipelineStageFromJson(json);

  Map<String, dynamic> toJson() => _$PipelineStageToJson(this);

  @override
  List<Object?> get props => [id, pipeline, stage, percentage, pic, picGroup];
}
