import 'package:airnav_helpdesk/core/services/theme_service.dart';

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

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }
}
