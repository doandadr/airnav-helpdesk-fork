import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:airnav_helpdesk/core/services/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  Get.put(ThemeService());
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    // Wrap dengan Obx agar reactive terhadap perubahan theme
    return Obx(() {
      // IMPORTANT: Access isDarkModeRx.value directly to register reactive dependency
      final isDark = themeService.isDarkModeRx.value;
      // Access refreshKey to force rebuild when it changes
      final key = themeService.refreshKey.value;

      return ShadTheme(
        data: isDark ? AppTheme.shadDark : AppTheme.shadLight,
        child: GetMaterialApp(
          key: ValueKey(key), // Force rebuild when key changes
          title: 'Helpdesk',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    });
  }
}
