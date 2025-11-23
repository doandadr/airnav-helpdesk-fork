// lib/modules/ticket/ticket_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel extends Equatable {
  final int id;

  // code shown in UI: T20250311W079
  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'created_at')
  final String createdAt; // keep as string for prototype

  final String category;
  @JsonKey(name: 'sub_category')
  final String? subCategory;

  // 0..100
  final int progress;

  // one of: new, assigned, in_progress, solved, waiting
  final String status;

  // small textual status shown right of card ("done", "in progress", "assigned", "new")
  @JsonKey(name: 'status_text')
  final String statusText;

  TicketModel({
    required this.id,
    required this.code,
    required this.createdAt,
    required this.category,
    this.subCategory,
    required this.progress,
    required this.status,
    required this.statusText,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);

  @override
  List<Object?> get props =>
      [id, code, createdAt, category, subCategory, progress, status, statusText];
}
