import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'pipeline.g.dart';

@JsonSerializable()
class Pipeline extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  const Pipeline({required this.id, required this.name});

  factory Pipeline.fromJson(Map<String, dynamic> json) =>
      _$PipelineFromJson(json);

  Map<String, dynamic> toJson() => _$PipelineToJson(this);

  @override
  List<Object?> get props => [id, name];
}
