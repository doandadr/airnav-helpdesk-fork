import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'pic_group.dart';

part 'pic_group_member.g.dart';

@JsonSerializable()
class PicGroupMember extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'pic_group')
  final PicGroup picGroup;
  @JsonKey(name: 'persnum')
  final String persnum;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'active')
  final bool active;

  const PicGroupMember({
    required this.id,
    required this.picGroup,
    required this.persnum,
    required this.name,
    required this.active,
  });

  factory PicGroupMember.fromJson(Map<String, dynamic> json) =>
      _$PicGroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$PicGroupMemberToJson(this);

  @override
  List<Object?> get props => [id, picGroup, persnum, name, active];
}
