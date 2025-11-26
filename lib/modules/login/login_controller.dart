import 'package:airnav_helpdesk/modules/dashboard/dashboard_controller.dart';
import 'package:airnav_helpdesk/modules/ticket/list/ticket_list_controller.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:airnav_helpdesk/main_page.dart';
import 'package:airnav_helpdesk/main_controller.dart';

import '../menu/menu_controller.dart';

class LoginController extends GetxController {
  final TextEditingController personnelNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isObscure = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void login() async {
    // if (personnelNumberController.text.isEmpty || passwordController.text.isEmpty) {
    //   Get.snackbar(
    //     'Error',
    //     'Please enter email and password',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   return;
    //   return;
    // }

    if (isLoading.value) return;

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    // Navigate to Main Page
    Get.offAll(
      () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.put(MainController());
        Get.put(DashboardController());
        Get.put(TicketListController());
        Get.put(MenuController());
      }),
    );
  }

  @override
  void onClose() {
    personnelNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
