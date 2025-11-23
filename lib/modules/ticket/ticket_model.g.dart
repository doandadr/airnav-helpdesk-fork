// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  createdAt: json['created_at'] as String,
  category: json['category'] as String,
  subCategory: json['sub_category'] as String?,
  progress: (json['progress'] as num).toInt(),
  status: json['status'] as String,
  statusText: json['status_text'] as String,
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'created_at': instance.createdAt,
      'category': instance.category,
      'sub_category': instance.subCategory,
      'progress': instance.progress,
      'status': instance.status,
      'status_text': instance.statusText,
    };
