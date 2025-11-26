import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ticket_model.dart';
import 'package:airnav_helpdesk/core/theme/app_theme.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final String activeTab; // New parameter

  const TicketCard({
    super.key,
    required this.ticket,
    required this.activeTab, // Pass the active tab
  });

  // --- Bottom Sheet Action ---
  void _showActionBottomSheet(
    BuildContext context, {
    required String title,
    required String hint,
  }) {
    Get.bottomSheet(
      // Prevents keyboard from covering the content
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: const BorderRadius.only(
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kode Tiket',
                        style: TextStyle(
                          color: Get.theme.textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ticket.code,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ticket.title,
                        style: TextStyle(
                          color: Get.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nota (Opsional)',
                  style: TextStyle(
                    color: Get.theme.textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Get.theme.textTheme.bodySmall?.color,
                    ),
                    filled: true,
                    fillColor:
                        Get.theme.inputDecorationTheme.fillColor ??
                        Get.theme.cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Get.theme.dividerColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Get.theme.dividerColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Get.theme.colorScheme.primary,
                      ),
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
    final ticketColors = Theme.of(context).extension<TicketColors>()!;
    return InkWell(
      onTap: () {
        // Navigate to detail only for 'Daftar Tiket' tab
        if (activeTab == 'Daftar Tiket') {
          Get.toNamed('/ticket/detail');
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Get.theme.dividerColor),
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
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Get.theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ticketColors.getStatusColor(ticket.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket.status,
                    style: TextStyle(
                      fontSize: 10,
                      color: ticketColors.getStatusTextColor(ticket.status),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ticketColors.getPriorityColor(ticket.priority),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket.priority,
                    style: TextStyle(
                      fontSize: 10,
                      color: ticketColors.getPriorityTextColor(ticket.priority),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              ticket.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Get.theme.textTheme.bodyLarge?.color,
              ),
            ),

            const SizedBox(height: 12),
            // --- Category Info ---
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 10,
                        color: Get.theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    Text(
                      ticket.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub Kategori',
                      style: TextStyle(
                        fontSize: 10,
                        color: Get.theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    Text(
                      ticket.subCategory,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.textTheme.bodyMedium?.color,
                      ),
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
                Text(
                  'Progres',
                  style: TextStyle(
                    fontSize: 10,
                    color: Get.theme.textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  '${ticket.progress}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.textTheme.bodyMedium?.color,
                  ),
                ),
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
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Get.theme.textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 4),
                Text(
                  ticket.lastUpdate,
                  style: TextStyle(
                    fontSize: 10,
                    color: Get.theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // --- Action Buttons ---
            _buildActionButtons(context),
          ],
        ),
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
        return const SizedBox.shrink();
    }
  }
}
