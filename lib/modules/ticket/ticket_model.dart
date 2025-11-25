import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
  final String code;
  final String title;
  final String date;

  final String category;
  final String subCategory;

  final int progress;               // 0–100
  final String status;              // SOLVED, ON PROCESS, WAITING, etc.
  final String priority;            // Low, Medium, High, Critical

  final String lastUpdate;          // formatted date: “16 Mar 2025, 12.17”
  final String lastUpdateStatus;    // Done, Assigned, New, In Progress

  const TicketModel({
    required this.code,
    required this.title,
    required this.date,
    required this.category,
    required this.subCategory,
    required this.progress,
    required this.status,
    required this.priority,
    required this.lastUpdate,
    required this.lastUpdateStatus,
  });

  @override
  List<Object?> get props => [
    code,
    title,
    date,
    category,
    subCategory,
    progress,
    status,
    priority,
    lastUpdate,
    lastUpdateStatus,
  ];
}
