// lib/modules/ticket/ticket_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_controller.dart';
import 'ticket_model.dart';

class TicketPage extends GetView<TicketController> {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Ticket',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // App-like header replaced by top tab row to match HTML
      body: SafeArea(
        child: Column(
          children: [
            // Tabs: My Tickets / New Ticket
            Obx(() {
              final idx = controller.tabIndex.value;
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _TabButton(
                      label: 'My Tickets',
                      active: idx == 0,
                      onTap: () => controller.setTab(0),
                    ),
                    const SizedBox(width: 16),
                    _TabButton(
                      label: 'New Ticket',
                      active: idx == 1,
                      onTap: () => controller.setTab(1),
                    ),
                  ],
                ),
              );
            }),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(Icons.search_outlined, color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => controller.searchQuery.value = v,
                      decoration: InputDecoration(
                        hintText: 'Search tickets...',
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 1) {
                  // placeholder create ticket quick view for prototype
                  return _NewTicketStub();
                }

                final list = controller.filteredTickets;
                if (list.isEmpty) {
                  return const Center(child: Text('No tickets'));
                }

                return RefreshIndicator(
                  onRefresh: controller.refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, idx) {
                      final t = list[idx];
                      return _TicketCard(ticket: t, onTapDetail: () => controller.openDetail(t));
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // simple create flow - opens a dialog to create a simple ticket
          _showCreateDialog(context);
        },
        backgroundColor: const Color(0xFF135CA1),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext ctx) {
    final titleCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();
    final subCtrl = TextEditingController();
    showDialog(
      context: ctx,
      builder: (c) => AlertDialog(
        title: const Text('Create ticket (demo)'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(hintText: 'Code / Title')),
          const SizedBox(height: 8),
          TextField(controller: categoryCtrl, decoration: const InputDecoration(hintText: 'Category')),
          const SizedBox(height: 8),
          TextField(controller: subCtrl, decoration: const InputDecoration(hintText: 'Sub category')),
        ]),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final code = titleCtrl.text.isEmpty ? 'T${DateTime.now().millisecondsSinceEpoch}' : titleCtrl.text;
              await Get.find<TicketController>().createTicket(
                titleCode: code,
                category: categoryCtrl.text.isEmpty ? 'GENERAL' : categoryCtrl.text,
                subCategory: subCtrl.text.isEmpty ? null : subCtrl.text,
              );
              Get.back();
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabButton({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Text(label, style: TextStyle(fontSize: 14, color: active ? const Color(0xFF135CA1) : Colors.grey[600])),
          ),
          if (active)
            Container(height: 3, width: 60, color: const Color(0xFF135CA1))
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final VoidCallback onTapDetail;
  const _TicketCard({required this.ticket, required this.onTapDetail});

  Color _progressColor(String status) {
    switch (status) {
      case 'solved':
        return Colors.green;
      case 'in_progress':
      case 'assigned':
        return Colors.blue;
      case 'waiting':
        return Colors.amber.shade700;
      default:
        return Colors.grey;
    }
  }

  Color _statusBg(String status) {
    switch (status) {
      case 'solved':
        return Colors.green.shade50;
      case 'in_progress':
      case 'assigned':
        return Colors.blue.shade50;
      case 'waiting':
        return Colors.yellow.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'solved':
        return Colors.green.shade700;
      case 'in_progress':
      case 'assigned':
        return Colors.blue.shade700;
      case 'waiting':
        return Colors.yellow.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = (ticket.progress / 100).clamp(0.0, 1.0);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header: code + date + status tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ticket.code, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(ticket.createdAt, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusBg(ticket.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket.status.toUpperCase(),
                    style: TextStyle(fontSize: 10, color: _statusTextColor(ticket.status), fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            // category / subcategory
            if (ticket.category.isNotEmpty) ...[
              const Text('Category', style: TextStyle(fontSize: 11, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(ticket.category, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
            ],
            if ((ticket.subCategory ?? '').isNotEmpty) ...[
              const Text('Sub Category', style: TextStyle(fontSize: 11, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(ticket.subCategory ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
            ],

            // Progress bar
            const Text('Progress', style: TextStyle(fontSize: 11, color: Colors.black54)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 8,
                      color: _progressColor(ticket.status),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${ticket.progress}%', style: const TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 12),

            // footer: timestamp icon + status text & View Details button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(ticket.createdAt, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ]),
                Row(children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(ticket.statusText, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ]),
              ],
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: onTapDetail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF175FA4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child: const Text('View Details', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewTicketStub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('New Ticket UI placeholder', style: TextStyle(color: Colors.grey[600])),
    );
  }
}
