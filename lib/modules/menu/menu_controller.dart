import 'package:airnav_helpdesk/core/services/theme_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MenuController extends GetxController {
  // User Info (bisa diambil dari auth service atau local storage)
  final RxString userName = 'Budi'.obs;
  final RxString userId = '10014377'.obs;
  final RxString userCompany = 'AIRNAV INDONESIA'.obs;

  final ThemeService _themeService = Get.find<ThemeService>();

  bool get isDarkMode => _themeService.isDarkMode;

  void toggleTheme() {
    _themeService.switchTheme();
    update(); // Force update to refresh UI if needed
  }

  // Bisa ditambahkan method untuk fetch user data dari API
  void fetchUserData() {
    // TODO: Implement fetch user data from API
  }

  // Handle menu navigation
  void navigateToInstallationGuide() {
    // TODO: Navigate to installation guide page
    Get.snackbar('Info', 'Navigasi ke Panduan Instalasi');
  }

  void navigateToDeviceRepair() {
    // TODO: Navigate to device repair page
    Get.snackbar('Info', 'Navigasi ke Perbaikan Perangkat');
  }

  void navigateToRepairData() {
    // TODO: Navigate to repair data page
    Get.snackbar('Info', 'Navigasi ke Data Perbaikan');
  }

  void navigateToNews() {
    // TODO: Navigate to news page
    Get.snackbar('Info', 'Navigasi ke News');
  }

  void navigateToFAQ() {
    // TODO: Navigate to FAQ page
    Get.toNamed('/faq');
  }

  void navigateToSettings() {
    // TODO: Navigate to settings page
    Get.snackbar('Info', 'Navigasi ke Settings');
  }

  void navigateToPrivacySecurity() {
    // TODO: Navigate to privacy & security page
    Get.snackbar('Info', 'Navigasi ke Privacy & Security');
  }

  void showLanguageBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'choose_language'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _buildLanguageOption(
              title: 'English',
              subtitle: 'US English',
              flag: '🇺🇸',
              code: 'en',
              country: 'US',
              isSelected: Get.locale?.languageCode == 'en',
            ),
            const SizedBox(height: 16),
            _buildLanguageOption(
              title: 'Indonesia',
              subtitle: 'Bahasa Indonesia',
              flag: '🇮🇩',
              code: 'id',
              country: 'ID',
              isSelected: Get.locale?.languageCode == 'id',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required String subtitle,
    required String flag,
    required String code,
    required String country,
    required bool isSelected,
  }) {
    final isDark = Get.isDarkMode;

    return InkWell(
      onTap: () {
        Get.updateLocale(Locale(code, country));
        Get.back();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(flag, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }
}
