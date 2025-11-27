import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:airnav_helpdesk/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/l10n/messages.dart';
import 'core/services/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/firebase_utils.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialMessage = await FirebaseUtils.setupFirebaseNotifications();
  await GetStorage.init();
  Get.put(ThemeService());
  Get.put(LocalizationService());
  runApp(MainApp());
  FirebaseUtils.handleInitialMessage(initialMessage);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return Obx(() {
      final isDark = themeService.isDarkModeRx.value;
      final key = themeService.refreshKey.value;

      return ShadTheme(
        data: isDark ? AppTheme.shadDark : AppTheme.shadLight,
        child: GetMaterialApp(
          key: ValueKey(key),
          title: 'Helpdesk',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          translations: Messages(),
          locale: Get.find<LocalizationService>().currentLocale,
          fallbackLocale: LocalizationService.fallbackLocale,
        ),
      );
    });
  }
}
