import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: AppBarWidget(
          titleText: 'notification_title'.tr,
          leading: IconButton(
            splashRadius: 24,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              splashRadius: 24,
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // TODO: Implement clear all notifications
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              _buildTab('notification_all'.tr),
              _buildTab('notification_unread'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationList(showUnreadOnly: false),
            _buildNotificationList(showUnreadOnly: true),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildNotificationList({required bool showUnreadOnly}) {
    // Data notifikasi statis untuk contoh
    final allNotifications = [
      _buildNotificationItem(
        icon: Icons.article_outlined,
        iconColor: Colors.blue[800]!,
        iconBgColor: Colors.blue[100]!,
        title: 'Tiket Dibuat',
        message:
            'Tiket baru #T2308-001 tentang "Printer Rusak" telah berhasil dibuat.',
        time: 'Baru saja',
        isUnread: true,
      ),
      _buildNotificationItem(
        icon: Icons.person_add_alt_1_outlined,
        iconColor: Colors.green[800]!,
        iconBgColor: Colors.green[100]!,
        title: 'Tiket Dialihkan',
        message: 'Tiket #T2308-002 dialihkan ke teknisi Budi Hartono.',
        time: '10 menit yang lalu',
        isUnread: true,
      ),
      _buildNotificationItem(
        icon: Icons.comment_outlined,
        iconColor: Colors.orange[800]!,
        iconBgColor: Colors.orange[100]!,
        title: 'Komentar Baru dari Admin',
        message:
            'Admin: "Mohon untuk melampirkan screenshot error yang muncul."',
        time: '1 jam yang lalu',
        isUnread: false,
      ),
      _buildNotificationItem(
        icon: Icons.check_circle_outline,
        iconColor: Colors.teal[800]!,
        iconBgColor: Colors.teal[100]!,
        title: 'Tiket Selesai',
        message:
            'Tiket #T2308-003 telah ditandai sebagai Selesai oleh teknisi.',
        time: '3 jam yang lalu',
        isUnread: false,
      ),
      _buildNotificationItem(
        icon: Icons.lock_clock_outlined,
        iconColor: Colors.purple[800]!,
        iconBgColor: Colors.purple[100]!,
        title: 'Tiket Ditutup Otomatis',
        message: 'Tiket #T2307-045 ditutup karena tidak ada balasan dari Anda.',
        time: 'Kemarin',
        isUnread: false,
      ),
      _buildNotificationItem(
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.red[800]!,
        iconBgColor: Colors.red[100]!,
        title: 'Peringatan SLA',
        message: 'Tiket #T2308-001 akan segera melampaui batas waktu SLA.',
        time: '1 hari yang lalu',
        isUnread: false,
      ),
      _buildNotificationItem(
        icon: Icons.support_agent_outlined,
        iconColor: Colors.cyan[800]!,
        iconBgColor: Colors.cyan[100]!,
        title: 'Balasan dari Teknisi',
        message: 'Budi Hartono: "Saya akan segera menuju ke lokasi Anda."',
        time: '2 hari yang lalu',
        isUnread: false,
      ),
    ];

    final notifications = showUnreadOnly
        ? allNotifications
              .where((n) => (n.key as ValueKey<bool>).value)
              .toList()
        : allNotifications;

    if (notifications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 100,
                color: Get.theme.disabledColor,
              ),
              const SizedBox(height: 24),
              Text(
                'notification_empty_title'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'notification_empty_desc'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Get.theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Separate lists for read and unread
    final unreadNotifications = notifications
        .where((n) => (n.key as ValueKey<bool>).value)
        .toList();
    final readNotifications = notifications
        .where((n) => !(n.key as ValueKey<bool>).value)
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: [
        if (unreadNotifications.isNotEmpty) ...[
          _buildDateHeader('notification_new'.tr),
          ...unreadNotifications,
          const SizedBox(height: 16),
        ],
        if (readNotifications.isNotEmpty) ...[
          _buildDateHeader('notification_earlier'.tr),
          ...readNotifications,
        ],
      ],
    );
  }

  Padding _buildDateHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ).copyWith(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      key: ValueKey(isUnread),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isUnread
            ? Get.theme.cardColor
            : (Get.isDarkMode ? Colors.grey[900] : const Color(0xFFF8F9FA)),
        borderRadius: BorderRadius.circular(12.0),
        border: isUnread ? null : Border.all(color: Get.theme.dividerColor),
        boxShadow: isUnread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            // TODO: Aksi ketika notifikasi di-tap
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Get.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: TextStyle(
                          color: Get.theme.textTheme.bodyMedium?.color,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Get.theme.textTheme.bodySmall?.color,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isUnread)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
