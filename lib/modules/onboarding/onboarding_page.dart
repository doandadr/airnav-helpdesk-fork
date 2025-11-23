import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }

    const primaryColor = Color(0xFF0D47A1);

    return ShadTheme(
      data: ShadThemeData(
        brightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              size: 80,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 48),
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B), // Darker text
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  children: [
                    // Page Indicators
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.items.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: controller.currentPage.value == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: controller.currentPage.value == index
                                  ? primaryColor
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Buttons
                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ShadButton(
                          backgroundColor: primaryColor,
                          onPressed: controller.nextPage,
                          child: Text(
                            controller.currentPage.value ==
                                controller.items.length - 1
                                ? 'Mulai'
                                : 'Lanjut',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                          () => SizedBox(
                        height: 50,
                        child: Visibility(
                          visible:
                          controller.currentPage.value !=
                              controller.items.length - 1,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: SizedBox(
                            width: double.infinity,
                            child: ShadButton.ghost(
                              onPressed: controller.skip,
                              child: const Text('Lewati'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}