import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airnav_helpdesk/main_page.dart';
import 'package:airnav_helpdesk/main_controller.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isObscure = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed('/main');
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // Navigate to Main Page
    Get.offAll(
      () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.put(MainController());
      }),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
