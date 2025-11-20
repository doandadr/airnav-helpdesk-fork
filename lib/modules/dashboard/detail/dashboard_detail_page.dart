import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_detail_controller.dart';

class DashboardDetailPage extends GetView<DashboardDetailController> {
  const DashboardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Detail'),
      ),
      body: Obx(() {
        final request = controller.helpRequest.value;
        if (request == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('From: ${request.name}'),
              const SizedBox(height: 8),
              Text('Date: ${request.date}'),
              const SizedBox(height: 8),
              Text('Status: ${request.status}'),
              const SizedBox(height: 16),
              const Text('Tags:', style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: request.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
