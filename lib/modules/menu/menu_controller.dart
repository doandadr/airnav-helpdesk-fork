import 'package:get/get.dart';
import '../faq/faq_page.dart';
class MenuController extends GetxController {
  // User Info (bisa diambil dari auth service atau local storage)
  final RxString userName = 'udi'.obs;
  final RxString userId = '10014377'.obs;
  final RxString userCompany = 'AIRNAV INDONESIA'.obs;

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
    // Get.toNamed('/faq');
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