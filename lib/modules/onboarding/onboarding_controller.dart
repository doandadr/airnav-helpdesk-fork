import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airnav_helpdesk/modules/login/login_page.dart';
import 'package:airnav_helpdesk/modules/login/login_controller.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: 'onboarding_title_1',
      description: 'onboarding_desc_1',
      icon: Icons.confirmation_number_outlined,
    ),
    OnboardingItem(
      title: 'onboarding_title_2',
      description: 'onboarding_desc_2',
      icon: Icons.timeline,
    ),
    OnboardingItem(
      title: 'onboarding_title_3',
      description: 'onboarding_desc_3',
      icon: Icons.support_agent,
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  void finishOnboarding() {
    // Navigate to Login Page
    Get.off(
      () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
