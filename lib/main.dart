import 'dart:convert';
import 'dart:io';

import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:airnav_helpdesk/core/services/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/l10n/messages.dart';
import 'core/services/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Handle background message (you can perform background work here)
  // Note: avoid heavy processing here.
}

// Local notifications plugin and channel
final AndroidNotificationChannel _fcMChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _ensureNotificationPermission() async {
  if (!Platform.isAndroid) return;

  final status = await Permission.notification.status;
  if (status.isGranted) return;

  final result = await Permission.notification.request();
  if (result.isDenied) {
    // ignore: avoid_print
    print('Notification permission denied by user.');
  }
}

void _handleRouteFromData(Map<String, dynamic> data) {
  if (data.isEmpty) return;

  final route = data['route'] as String?;
  if (route != null && route.isNotEmpty) {
    Get.toNamed(route, arguments: data);
    return;
  }

  Get.toNamed(Routes.DASHBOARD, arguments: data);
}

void _handleMessageNavigation(RemoteMessage message) {
  _handleRouteFromData(Map<String, dynamic>.from(message.data));
}

void _handleLocalNotificationTap(NotificationResponse response) {
  final payload = response.payload;
  if (payload == null || payload.isEmpty) return;

  try {
    final decoded = jsonDecode(payload);
    if (decoded is Map<String, dynamic>) {
      _handleRouteFromData(decoded);
    }
  } catch (_) {
    // ignore malformed payloads
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize local notifications for showing foreground notifications
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(_fcMChannel);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await _flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: _handleLocalNotificationTap,
  );

  // Request permissions on iOS/macOS
  try {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  } catch (e) {
    // ignore
  }

  await _ensureNotificationPermission();

  // Print the FCM token for debugging (you can send this to your server)
  FirebaseMessaging.instance.getToken().then((token) {
    if (token != null) {
      // ignore: avoid_print
      print('FCM Token: $token');
    }
  });

  // Show a local notification when a message is received while app is in foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _fcMChannel.id,
            _fcMChannel.name,
            channelDescription: _fcMChannel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  });

  // Handle notification taps when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);

  await GetStorage.init();
  await GetStorage.init();
  Get.put(ThemeService());
  Get.put(LocalizationService());
  runApp(MainApp());

  if (initialMessage != null) {
    Future.microtask(() => _handleMessageNavigation(initialMessage));
  }
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
          translations: Messages(),
          locale: Get.find<LocalizationService>().currentLocale,
          fallbackLocale: LocalizationService.fallbackLocale,
        ),
      );
    });
  }
}
