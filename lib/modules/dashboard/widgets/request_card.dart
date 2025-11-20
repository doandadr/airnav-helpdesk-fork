import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_pages.dart';
import '../models/help_request.dart';

class RequestCard extends StatelessWidget {
  final HelpRequest request;

  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black54),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Get.toNamed(Routes.DASHBOARD_DETAIL, arguments: request),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  // avatar
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade200,
                    child:
                        const Icon(Icons.person_outline, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  // name + title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${request.date} • ${request.responseDue}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  // NEW / OVERDUE badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: request.highlight == 'NEW'
                          ? Colors.green.shade400
                          : Colors.red.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      request.highlight,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // tags row like chips
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  for (var t in request.tags)
                    Chip(
                      label: Text(t, style: const TextStyle(fontSize: 12)),
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: Colors.black26),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // bottom row: status / open button
              Row(
                children: [
                  // small badge "Urgent" (example)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Urgent',
                        style: TextStyle(fontSize: 12, color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      request.tags.length > 1 ? request.tags[1] : '',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // status button (Open)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      request.status,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
