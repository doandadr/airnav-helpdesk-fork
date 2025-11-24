import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ticket_model.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final String activeTab; // New parameter

  const TicketCard({
    super.key,
    required this.ticket,
    required this.activeTab, // Pass the active tab
  });

  // --- Color Helpers ---
  Color _statusColor(String status) {
    switch (status) {
      case 'Done':
        return Colors.green.shade50;
      case 'In Progress':
        return Colors.blue.shade50;
      case 'Assigned':
        return Colors.yellow.shade50;
      case 'New':
        return Colors.purple.shade50;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Done':
        return Colors.green.shade800;
      case 'In Progress':
        return Colors.blue.shade800;
      case 'Assigned':
        return Colors.yellow.shade800;
      case 'New':
        return Colors.purple.shade800;
      default:
        return Colors.grey.shade800;
    }
  }

  Color _priorityTextColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red.shade800;
      case 'High':
        return Colors.orange.shade800;
      case 'Medium':
        return Colors.yellow.shade800;
      case 'Low':
        return Colors.green.shade800;
      default:
        return Colors.grey.shade800;
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red.shade50;
      case 'High':
        return Colors.orange.shade50;
      case 'Medium':
        return Colors.yellow.shade50;
      case 'Low':
        return Colors.green.shade50;
      default:
        return Colors.grey.shade200;
    }
  }

  // --- Bottom Sheet Action ---
  void _showActionBottomSheet(BuildContext context,
      {required String title, required String hint}) {
    Get.bottomSheet(
      // Prevents keyboard from covering the content
      SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kode Tiket',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(ticket.code,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(ticket.title),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Nota (Opsional)',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: title == 'Tolak Tiket'
                          ? Colors.red
                          : const Color(0xFF175fa4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(title.split(' ').first),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Ticket Header ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ticket.code,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(ticket.status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket.status,
                  style: TextStyle(
                      fontSize: 10, color: _statusTextColor(ticket.status)),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _priorityColor(ticket.priority),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket.priority,
                  style: TextStyle(
                    fontSize: 10,
                    color: _priorityTextColor(ticket.priority),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            ticket.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),
          // --- Category Info ---
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(ticket.category, style: const TextStyle(fontSize: 12)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sub Kategori',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    ticket.subCategory,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          // --- Progress Bar ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progres',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text('${ticket.progress}%', style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ticket.progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: ticket.progress == 100 ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),
          // --- Last Update ---
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                ticket.lastUpdate,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),

          const SizedBox(height: 16),
          // --- Action Buttons ---
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (activeTab) {
      case 'Menunggu Konfirmasi':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.close, size: 16),
                label: const Text('Tolak'),
                onPressed: () => _showActionBottomSheet(
                  context,
                  title: 'Tolak Tiket',
                  hint: 'Ketik alasan menolak...',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade700,
                  backgroundColor: Colors.red.shade50,
                  side: BorderSide(color: Colors.red.shade200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check, size: 16),
                label: const Text('Terima'),
                onPressed: () => _showActionBottomSheet(
                  context,
                  title: 'Terima Tiket',
                  hint: 'Ketik keterangan terima...',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF175fa4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Menunggu Penugasan':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.close, size: 16),
                label: const Text('Tolak'),
                onPressed: () => _showActionBottomSheet(
                  context,
                  title: 'Tolak Tiket',
                  hint: 'Ketik alasan tidak menyetujui tiket...',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade700,
                  backgroundColor: Colors.red.shade50,
                  side: BorderSide(color: Colors.red.shade200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.people_alt_outlined, size: 16),
                label: const Text('Tugaskan'),
                onPressed: () {
                  Get.toNamed(Routes.ASSIGN_TICKET);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF175fa4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Daftar Tiket':
      default:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF175fa4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.toNamed('/ticket/detail');
            },
            child: const Text(
              'Lihat Detail',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
    }
  }
}
