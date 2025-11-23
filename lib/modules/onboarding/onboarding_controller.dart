import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airnav_helpdesk/modules/login/login_page.dart';
import 'package:airnav_helpdesk/modules/login/login_controller.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: 'Easy Ticketing',
      description:
          'Create and manage support tickets with ease. Get your issues resolved faster.',
      icon: Icons.confirmation_number_outlined,
    ),
    OnboardingItem(
      title: 'Track Progress',
      description:
          'Monitor the status of your requests in real-time. Stay informed every step of the way.',
      icon: Icons.timeline,
    ),
    OnboardingItem(
      title: 'Quick Support',
      description:
          'Access our FAQ or contact support directly. We are here to help you.',
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
