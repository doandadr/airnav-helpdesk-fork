class HelpRequest {
  final String name;
  final String title;
  final String date;
  final String responseDue;
  final List<String> tags;
  final String status;
  final String highlight; // e.g., NEW or OVERDUE

  HelpRequest({
    required this.name,
    required this.title,
    required this.date,
    required this.responseDue,
    required this.tags,
    required this.status,
    required this.highlight,
  });
}
