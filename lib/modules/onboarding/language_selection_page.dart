import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:airnav_helpdesk/core/services/localization_service.dart';
import 'welcome_page.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShadTheme(
      data: ShadThemeData(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const WelcomePage());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'skip'.tr,
                          style: GoogleFonts.montserrat(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.skip_next,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Language Icon Placeholder
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: -0.2,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'A',
                            style: GoogleFonts.montserrat(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(40, -40),
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'ID',
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'choose_language'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLanguageButton(
                  context,
                  'english'.tr,
                  isSelected: Get.locale?.languageCode == 'en',
                  onTap: () {
                    Get.find<LocalizationService>().changeLocale('English');
                  },
                ),
                const SizedBox(height: 16),
                _buildLanguageButton(
                  context,
                  'indonesia'.tr,
                  isSelected: Get.locale?.languageCode == 'id',
                  onTap: () {
                    Get.find<LocalizationService>().changeLocale('Indonesia');
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'change_language_later'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isSelected
          ? ShadButton(
              backgroundColor: const Color(
                0xFF26C6DA,
              ), // Cyan color from design
              onPressed: () {
                onTap();
                Get.to(() => const WelcomePage());
              },
              child: Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          : ShadButton.outline(
              backgroundColor: Colors.white,
              onPressed: () {
                onTap();
                Get.to(() => const WelcomePage());
              },
              child: Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D47A1), // Primary blue
                ),
              ),
            ),
    );
  }
}
