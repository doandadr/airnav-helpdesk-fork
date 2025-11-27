// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pic_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicGroup _$PicGroupFromJson(Map<String, dynamic> json) => PicGroup(
  id: (json['id'] as num).toInt(),
  picGroup: json['pic_group'] as String,
  description: json['description'] as String,
  active: json['active'] as bool,
);

Map<String, dynamic> _$PicGroupToJson(PicGroup instance) => <String, dynamic>{
  'id': instance.id,
  'pic_group': instance.picGroup,
  'description': instance.description,
  'active': instance.active,
};
