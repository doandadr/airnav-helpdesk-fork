import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'pic_group.g.dart';

@JsonSerializable()
class PicGroup extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'pic_group')
  final String picGroup;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'active')
  final bool active;

  const PicGroup({
    required this.id,
    required this.picGroup,
    required this.description,
    required this.active,
  });

  factory PicGroup.fromJson(Map<String, dynamic> json) =>
      _$PicGroupFromJson(json);

  Map<String, dynamic> toJson() => _$PicGroupToJson(this);

  @override
  List<Object?> get props => [id, picGroup, description, active];
}
