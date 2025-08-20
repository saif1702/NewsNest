import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

// Track the currently visible news ID
String? currentNewsId;

// Initialize plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final newsId =
      message.data['newsId']; // make sure your FCM payload includes newsId
  final title = message.notification?.title ?? 'News';
  final body = message.notification?.body ?? '';

  if (newsId != currentNewsId) {
    _showNotification(newsId, title, body);
  }
}

// Show notification helper
Future<void> _showNotification(
  String? newsId,
  String title,
  String body,
) async {
  if (newsId != null && newsId == currentNewsId) return; // skip current news

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'news_channel',
    'News Notifications',
    channelDescription: 'Channel for news updates',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    title.hashCode,
    title,
    body,
    platformDetails,
  );
}

class NotificationService {
  Future<void> init() async {
    await Firebase.initializeApp();

    // Request permission
    await FirebaseMessaging.instance.requestPermission();

    // Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final newsId = message.data['newsId'];
      final title = message.notification?.title ?? 'News';
      final body = message.notification?.body ?? '';
      _showNotification(newsId, title, body);
    });

    // On notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.notification?.title}');
    });
  }

  Future<void> showLocalNotification(
    String newsId,
    String title,
    String body,
  ) async {
    await _showNotification(newsId, title, body);
  }
}
