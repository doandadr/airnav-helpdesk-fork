import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'detail_ticket_controller.dart';
import 'package:airnav_helpdesk/core/theme/app_theme.dart';

class DetailTicketPage extends GetView<DetailTicketController> {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketColors = Theme.of(context).extension<TicketColors>()!;
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        titleText: 'ticket_detail_title'.tr,
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatusCard(ticketColors),
                  const SizedBox(height: 16),
                  _buildReporterCard(),
                  const SizedBox(height: 16),
                  _buildProblemDescriptionCard(),
                  const SizedBox(height: 16),
                  _buildTimelineCard(),
                  const SizedBox(height: 16),
                  _buildTicketInfoCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatusCard(TicketColors ticketColors) {
    return _buildCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChip(
                'IN PROCESS',
                ticketColors.getStatusColor('In Progress'),
                ticketColors.getStatusTextColor('In Progress'),
              ),
              _buildChip(
                'High',
                ticketColors.getPriorityColor('High'),
                ticketColors.getPriorityTextColor('High'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Progress',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const Spacer(),
              const Text(
                '75%',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReporterCard() {
    return _buildCard(
      child: Column(
        children: [
          _buildSectionHeader(
            'reporter_section'.tr,
            Icons.person_outline,
            Colors.blue.shade700,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReadOnlyField('nik_label'.tr, '10014377'),
                const SizedBox(height: 16),
                _buildReadOnlyField('name_label'.tr, 'M NABIL AMANI'),
                const SizedBox(height: 16),
                _buildReadOnlyField('department_label'.tr, 'AIRNAV INDONESIA'),
                const SizedBox(height: 16),
                _buildReadOnlyField(
                  'sub_department_label'.tr,
                  'CORPORATE SERVICES DIVISION',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildProblemDescriptionCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'description_section'.tr,
            Icons.description_outlined,
            Colors.red.shade700,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildReadOnlyField(
                        'category_label'.tr,
                        'Jaringan',
                      ),
                    ),
                    Expanded(
                      child: _buildReadOnlyField(
                        'sub_category_label'.tr,
                        'WIFI',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildReadOnlyField('channel_label'.tr, 'IT'),
                    ),
                    Expanded(
                      child: _buildReadOnlyField(
                        'pipeline_label'.tr,
                        'Tiket untuk IT',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildReadOnlyField('source_label'.tr, 'Portal'),
                    ),
                    Expanded(child: _buildReadOnlyField('Assignee', 'BUDI')),
                  ],
                ),
                const SizedBox(height: 16),
                _buildReadOnlyField('SLA Policy', 'SLA untuk IT'),
                const SizedBox(height: 16),
                _buildReadOnlyField(
                  'subject_label'.tr,
                  'Tidak bisa connect ke WIFI kantor',
                ),
                const SizedBox(height: 16),
                _buildReadOnlyField(
                  'description_label'.tr,
                  'Saya mengalami masalah ketika mencoba connect ke WIFI kantor. Sudah mencoba beberapa kali restart device tapi tetap tidak bisa connect. Mohon bantuan segera karena pekerjaan saya memerlukan akses internet.',
                ),
                const SizedBox(height: 16),
                _buildAttachmentChip(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildFooterChip(
                      Icons.calendar_today_outlined,
                      'due_date_label'.tr,
                      '16 Mar 2025, 12.17',
                      Colors.blue.shade700,
                    ),
                    const SizedBox(width: 16),
                    _buildFooterChip(
                      LucideIcons.hourglass,
                      'stage_label'.tr,
                      'On Process',
                      Colors.purple.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.link, color: Colors.grey.shade600, size: 18),
          const SizedBox(width: 8),
          Text(
            'screenshot_wifi_error.png',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterChip(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    return _buildCard(
      child: Column(
        children: [
          _buildSectionHeader(
            'timeline_section'.tr,
            Icons.timeline,
            Colors.green.shade700,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Column(
              children: [
                _buildTimelineStep(
                  'timeline_created'.tr,
                  'timeline_created_desc'.tr,
                  '2025-03-13 12:17:31',
                  isFirst: true,
                ),
                // _buildTimelineStep('Approved', 'Ticket disetujui oleh Manager', '2025-03-13 12:30:15'),
                _buildTimelineStep(
                  'timeline_assigned'.tr,
                  'timeline_assigned_desc'.tr,
                  '2025-03-13 13:00:00',
                ),
                _buildTimelineStep(
                  'On Process',
                  'timeline_process_desc'.tr,
                  '2025-03-13 14:30:00',
                  isLast: true,
                  isActive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    String date, {
    bool isFirst = false,
    bool isLast = false,
    bool isActive = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              if (!isFirst)
                Expanded(
                  child: Container(width: 1, color: Colors.grey.shade300),
                ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1, color: Colors.grey.shade300),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isActive
                          ? Colors.blue
                          : Get.theme.textTheme.bodyLarge?.color,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfoCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'ticket_info_section'.tr,
            Icons.info_outline,
            Colors.blueGrey.shade700,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ticket_id'.tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      'T20250311W079',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'created_date'.tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      '2025-03-13 12:17:31',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
