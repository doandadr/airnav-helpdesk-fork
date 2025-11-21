import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_controller.dart' as menu_ctrl;

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller langsung di sini untuk menghindari error "not found"
    final controller = Get.put(menu_ctrl.MenuController());
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile Section
            _buildProfileHeader(controller),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informasi & Bantuan Section
                  _buildSectionTitle('INFORMASI & BANTUAN'),
                  const SizedBox(height: 12),
                  _buildInfoCard(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Pengaturan Section
                  _buildSectionTitle('PENGATURAN'),
                  const SizedBox(height: 12),
                  _buildSettingsCard(controller),
                  
                  const SizedBox(height: 16),
                  
                  // Logout Button
                  _buildLogoutButton(),
                  
                  const SizedBox(height: 16),
                  
                  // Footer
                  _buildFooter(),
                  
                  const SizedBox(height: 80), // Space for bottom navigation
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(menu_ctrl.MenuController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF135CA1),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF0F3C5C),
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          // User Info
          Expanded(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userName.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userId.value,
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 12,
                  ),
                ),
                Text(
                  controller.userCompany.value,
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 12,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoCard(menu_ctrl.MenuController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.book_outlined,
            iconColor: const Color(0xFF135CA1),
            title: 'Panduan Instalasi',
            onTap: controller.navigateToInstallationGuide,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.build_outlined,
            iconColor: const Color(0xFFDA251D),
            title: 'Perbaikan Perangkat',
            onTap: controller.navigateToDeviceRepair,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.storage_outlined,
            iconColor: const Color(0xFF2980B9),
            title: 'Data Perbaikan',
            onTap: controller.navigateToRepairData,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.article_outlined,
            iconColor: const Color(0xFF17568A),
            title: 'News',
            onTap: controller.navigateToNews,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.help_outline,
            iconColor: const Color(0xFF0F3C5C),
            title: 'FAQ',
            onTap: controller.navigateToFAQ,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(menu_ctrl.MenuController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.settings_outlined,
            iconColor: Colors.grey[600]!,
            title: 'Settings',
            onTap: controller.navigateToSettings,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.shield_outlined,
            iconColor: Colors.grey[700]!,
            title: 'Privacy & Security',
            onTap: controller.navigateToPrivacySecurity,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Arrow
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[100],
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement logout logic
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red[600],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            'Helpdesk System v1.0.0',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2025 AIRNAV Indonesia',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}