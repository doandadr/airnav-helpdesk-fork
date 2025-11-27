import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:airnav_helpdesk/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      if (e.toString().contains('duplicate-app')) {
        // Ignore duplicate app error
      } else {
        rethrow;
      }
    }
  }
  // Handle background message (you can perform background work here)
  // Note: avoid heavy processing here.
}

class FirebaseUtils {
  static final AndroidNotificationChannel _fcMChannel =
      AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<RemoteMessage?> setupFirebaseNotifications() async {
    if (Firebase.apps.isEmpty) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } catch (e) {
        if (e.toString().contains('duplicate-app')) {
          // Ignore duplicate app error
          print('Firebase already initialized: $e');
        } else {
          rethrow;
        }
      }
    }

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Initialize local notifications for showing foreground notifications
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_fcMChannel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
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
        // http.post(
        //   Uri.parse('https://fcm.googleapis.com/fcm/send'),
        //   body: {
        //     'to': token,
        //     'notification': {'title': 'FCM Token', 'body': 'FCM Token: $token'},
        //   },
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'Authorization': 'key=YOUR_SERVER_KEY',
        //   },
        // );
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

    return initialMessage;
  }

  static Future<void> _ensureNotificationPermission() async {
    if (!Platform.isAndroid) return;

    final status = await Permission.notification.status;
    if (status.isGranted) return;

    final result = await Permission.notification.request();
    if (result.isDenied) {
      // ignore: avoid_print
      print('Notification permission denied by user.');
    }
  }

  static void _handleRouteFromData(Map<String, dynamic> data) {
    if (data.isEmpty) return;

    final route = data['route'] as String?;
    if (route != null && route.isNotEmpty) {
      Get.toNamed(route, arguments: data);
      return;
    }

    Get.toNamed(Routes.DASHBOARD, arguments: data);
  }

  static void _handleMessageNavigation(RemoteMessage message) {
    _handleRouteFromData(Map<String, dynamic>.from(message.data));
  }

  static void _handleLocalNotificationTap(NotificationResponse response) {
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

  static void handleInitialMessage(RemoteMessage? message) {
    if (message != null) {
      Future.microtask(() => _handleMessageNavigation(message));
    }
  }
}
