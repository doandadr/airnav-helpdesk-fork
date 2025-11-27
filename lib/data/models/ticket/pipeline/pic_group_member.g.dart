// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pic_group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicGroupMember _$PicGroupMemberFromJson(Map<String, dynamic> json) =>
    PicGroupMember(
      id: (json['id'] as num).toInt(),
      picGroup: PicGroup.fromJson(json['pic_group'] as Map<String, dynamic>),
      persnum: json['persnum'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$PicGroupMemberToJson(PicGroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pic_group': instance.picGroup,
      'persnum': instance.persnum,
      'name': instance.name,
      'active': instance.active,
    };
