import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/config/app_pages.dart';
import '../models/help_request.dart';

class RequestCard extends StatelessWidget {
  final HelpRequest request;

  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.TICKET_DETAIL, arguments: request),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                // name + title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        request.title,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                // NEW / OVERDUE badge
                ShadBadge(
                  backgroundColor: request.highlight == 'NEW'
                      ? Colors.green.shade500
                      : Colors.red.shade500,
                  child: Text(
                    request.highlight,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // tags row like chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var t in request.tags)
                  ShadBadge.secondary(
                    child: Text(t, style: const TextStyle(fontSize: 11)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // bottom row: status / open button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${request.date} • ${request.responseDue}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                ShadBadge.outline(
                  child: Text(
                    request.status,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
