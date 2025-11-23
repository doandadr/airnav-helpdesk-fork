import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_ticket_controller.dart';

class DetailTicketPage extends GetView<DetailTicketController> {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Detail'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', controller.request.date),
            const SizedBox(height: 16),
            _buildDetailRow('Requester', controller.request.name),
            const SizedBox(height: 16),
            _buildDetailRow('Tags', controller.request.tags.join(', ')),
            const SizedBox(height: 16),
            _buildDetailRow('Status', controller.request.status),
            const SizedBox(height: 16),
            _buildDetailRow(
              'Subject',
              controller.request.title,
              maxLines: null,
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Response Due', controller.request.responseDue),
            const SizedBox(height: 16),
            _buildDetailRow(
              'Description',
              controller.request.description ?? '',
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {int? maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.titleSmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Get.textTheme.bodyLarge,
          maxLines: maxLines,
          overflow: maxLines == null
              ? TextOverflow.visible
              : TextOverflow.ellipsis,
        ),
        const Divider(height: 16),
      ],
    );
  }
}
