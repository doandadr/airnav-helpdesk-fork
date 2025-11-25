import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airnav_helpdesk/modules/login/login_page.dart';
import 'package:airnav_helpdesk/modules/login/login_controller.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: 'Lapor Kendala Lebih Mudah',
      description:
      'Buat tiket untuk kendala teknis atau administratif, lampirkan foto, dan kirim langsung dari genggaman Anda.',
      icon: Icons.confirmation_number_outlined,
    ),
    OnboardingItem(
      title: 'Pantau Status Tiket Real-Time',
      description:
      'Dapatkan notifikasi instan dan lihat progres penyelesaian tiket Anda, mulai dari penugasan hingga selesai.',
      icon: Icons.timeline,
    ),
    OnboardingItem(
      title: 'Pusat Bantuan Terintegrasi',
      description:
      'Temukan jawaban cepat melalui FAQ atau berkomunikasi langsung dengan asisten AI melalui fitur chat.',
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