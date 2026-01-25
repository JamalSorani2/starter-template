import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:{{app_name}}/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../imports/imports.dart';

class NotificationService {
  // ─────────────────────────────────────────────────────────────
  // INITIALIZATION
  // ─────────────────────────────────────────────────────────────

  Future<void> initialize() async {
    await _initAwesomeNotifications();
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initFirebaseMessaging();
    _initAwesomeListeners();
  }

  Future<void> _initAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: KNotificationChannelKey,
          channelName: 'General Notifications',
          channelDescription: 'App notifications',
          importance: NotificationImportance.High,
          playSound: true,
          enableVibration: true,
          channelShowBadge: true,
          defaultColor: AppColors.primary,
          ledColor: AppColors.onSecondary,
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // ignore: unused_element
  Future<void> _initFirebaseMessaging() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    // ───── Token (cache once) ─────
    final token = await fcm.getToken();
    if (token != null) {
      await _cacheToken(token);
      log('FCM Token cached: $token');
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _cacheToken(newToken);
      log('FCM Token refreshed & cached: $newToken');
    });

    // ───── App terminated ─────
    final initialMessage = await fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleFirebaseMessage(initialMessage);
    }

    // ───── Background → Opened ─────
    FirebaseMessaging.onMessageOpenedApp.listen(_handleFirebaseMessage);

    // ───── Foreground ─────
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  // ─────────────────────────────────────────────────────────────
  // TOPICS
  // ─────────────────────────────────────────────────────────────

  Future<void> subscribeInitialTopics(String? userId) async {
    await FirebaseMessaging.instance.subscribeToTopic('general');
    log('Subscribed to topic: general');

    if (userId != null && userId.isNotEmpty) {
      await FirebaseMessaging.instance.subscribeToTopic('user_$userId');
      log('Subscribed to topic: user_$userId');
    }
  }

  Future<void> _unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    log('Unsubscribed from topic: $topic');
  }

  // ─────────────────────────────────────────────────────────────
  // LOGOUT (PUBLIC API)
  // ─────────────────────────────────────────────────────────────

  Future<void> logout({String? userId}) async {
    // Topics
    await _unsubscribeFromTopic('general');

    if (userId != null && userId.isNotEmpty) {
      await _unsubscribeFromTopic('user_$userId');
    }

    // Token
    await _clearToken();
  }

  // ─────────────────────────────────────────────────────────────
  // AWESOME LISTENERS
  // ─────────────────────────────────────────────────────────────

  void _initAwesomeListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // FIREBASE HANDLING
  // ─────────────────────────────────────────────────────────────

  void _handleForegroundMessage(RemoteMessage message) {
    showLocal(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: message.data.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  void _handleFirebaseMessage(RemoteMessage message) {
    _handleDeepLink(message.data);
  }

  // ─────────────────────────────────────────────────────────────
  // LOCAL NOTIFICATIONS
  // ─────────────────────────────────────────────────────────────

  Future<void> showLocal({
    required String title,
    required String body,
    Map<String, String>? payload,
    String? icon,
    String? largeIcon,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: KNotificationChannelKey,
        title: title,
        body: body,
        payload: payload,
        icon: icon,
        largeIcon: largeIcon,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // DEEP LINK
  // ─────────────────────────────────────────────────────────────

  void _handleDeepLink(Map<String, dynamic>? payload) {
    if (payload == null || payload.isEmpty) {
      return;
    }

    final route = payload['route'];
    final id = payload['id'];

    if (route == null) {
      return;
    }

    log('Navigate → $route | id: $id');

    // AppNavigator.pushNamed(route, arguments: id);
  }

  // ─────────────────────────────────────────────────────────────
  // TOKEN CACHE
  // ─────────────────────────────────────────────────────────────

  Future<void> _cacheToken(String token) async {
    await getIt<SharedPreferences>().setString(KFcmTokenKey, token);
  }

  Future<String?> getCachedToken() async {
    return getIt<SharedPreferences>().getString(KFcmTokenKey);
  }

  Future<void> _clearToken() async {
    await getIt<SharedPreferences>().remove(KFcmTokenKey);
    await FirebaseMessaging.instance.deleteToken();
    log('FCM Token cleared');
  }

  // ─────────────────────────────────────────────────────────────
  // UTILITIES
  // ─────────────────────────────────────────────────────────────

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
