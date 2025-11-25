import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Use RxBool for reactive state - public to allow direct reactive access
  late final RxBool isDarkModeRx;

  // Key to force app rebuild
  final RxInt refreshKey = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize from storage or default to false (light mode)
    isDarkModeRx = RxBool(_box.read(_key) ?? false);
    // Apply initial theme mode
    Get.changeThemeMode(isDarkModeRx.value ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode get theme => isDarkModeRx.value ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkMode => isDarkModeRx.value;

  void switchTheme() {
    isDarkModeRx.value = !isDarkModeRx.value;
    // Update theme mode
    Get.changeThemeMode(isDarkModeRx.value ? ThemeMode.dark : ThemeMode.light);
    // Increment key to force GetMaterialApp rebuild
    refreshKey.value++;
    _box.write(_key, isDarkModeRx.value);
  }
}
