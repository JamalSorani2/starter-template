import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:{{app_name}}/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../imports/imports.dart';

@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction action) async {
  log('🔔 Background action received');
  log('Button: ${action.buttonKeyPressed}');
  log('Payload: ${action.payload}');
  _handleDeepLink(action.payload ?? {});
}

class NotificationService {
  static const String channelKey = "basic_channel";

  // ─────────────────────────────────────────
  // INITIALIZE
  // ─────────────────────────────────────────

  Future<void> initialize() async {
    await _initAwesomeNotifications();
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    await _initFirebaseMessaging();
    _initAwesomeListeners();
  }

  // ─────────────────────────────────────────
  // AWESOME NOTIFICATIONS
  // ─────────────────────────────────────────

  Future<void> _initAwesome() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: channelKey,
          channelName: 'General Notifications',
          channelDescription: 'App notifications',
          importance: NotificationImportance.High,
          playSound: true,
          enableVibration: true,
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    log("Subscribed to topic: $topic");
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    log("Unsubscribed from topic: $topic");
  }

  void _initListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // ─────────────────────────────────────────
  // FIREBASE MESSAGING
  // ─────────────────────────────────────────

  Future<void> _initFirebase() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      await messaging.requestPermission();
    } on FirebaseException catch (e, s) {
      log(
        'FCM requestPermission failed: ${e.code} - ${e.message}',
        stackTrace: s,
      );
    } catch (e, s) {
      log('FCM requestPermission failed: $e', stackTrace: s);
    }

    // Token
    try {
      final String? token = await messaging.getToken();
      if (token != null) {
        await _cacheToken(token);
        log('FCM Token: $token');
      }
    } on FirebaseException catch (e, s) {
      // Common transient issue on some devices/services:
      // [firebase_messaging/unknown] ... SERVICE_NOT_AVAILABLE
      log(
        'FCM getToken failed: ${e.code} - ${e.message}',
        stackTrace: s,
      );
    } catch (e, s) {
      log('FCM getToken failed: $e', stackTrace: s);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _cacheToken(newToken);
      log('Token refreshed: $newToken');
    });

    // Foreground
    FirebaseMessaging.onMessage.listen(_handleForeground);

    // Opened from background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Terminated state
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleForeground(RemoteMessage message) async {
    final data = message.data;
    printC(data);
    String? file;
    final imageUrl = data["imageUrl"];
    if (imageUrl != null) {
      file = await downloadAndCacheImage(imageUrl);
    }
    showLocal(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      imageUrl: file != null ? "file://$file" : imageUrl,
      payload:
          message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  void _handleMessage(RemoteMessage message) {
    _handleDeepLink(message.data);
  }

  // ─────────────────────────────────────────
  // LOCAL NOTIFICATION
  // ─────────────────────────────────────────

  Future<void> showLocal({
    required String title,
    required String body,
    required String? imageUrl,
    Map<String, String>? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey,
        title: title,
        body: body,
        largeIcon: imageUrl,
        payload: payload,
      ),
    );
  }

  // ─────────────────────────────────────────
  // DEEP LINK HANDLER
  // ─────────────────────────────────────────

  // ─────────────────────────────────────────
  // TOKEN CACHE
  // ─────────────────────────────────────────

  Future<void> _cacheToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fcm_token", token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("fcm_token");
    token = await prefs.getString("fcm_token");
    return token;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("fcm_token");
    try {
      await FirebaseMessaging.instance.deleteToken();
    } on FirebaseException catch (e, s) {
      // Can happen on some devices/network states (e.g. SERVICE_NOT_AVAILABLE).
      // Logout must continue even if FCM token deletion fails remotely.
      log(
        'FCM deleteToken failed during logout: ${e.code} - ${e.message}',
        stackTrace: s,
      );
    } catch (e, s) {
      log(
        'FCM deleteToken failed during logout: $e',
        stackTrace: s,
      );
    }
  }

  // ─────────────────────────────────────────
  // UTILITIES
  // ─────────────────────────────────────────

  Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
  }

  Future<bool> hasPermission() async {
    return AwesomeNotifications().isNotificationAllowed();
  }
}

@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction action) async {
  log('🔔 Action received: ${action.buttonKeyPressed}');
  log('Payload: ${action.payload}');
}

@pragma('vm:entry-point')
Future<void> onNotificationCreatedMethod(
  ReceivedNotification notification,
) async {
  log('🔔 Notification created');
}

@pragma('vm:entry-point')
Future<void> onNotificationDisplayedMethod(
  ReceivedNotification notification,
) async {
  log('🔔 Notification displayed');
}

@pragma('vm:entry-point')
Future<void> onDismissActionReceivedMethod(
  ReceivedAction action,
) async {
  log('🔔 Notification dismissed');
}
