import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsnest/view/notifications_screen.dart'; // ⬅ new screen
import 'package:newsnest/model/newsArt.dart'; // ⬅ needed for NewsArt model

String? currentNewsId;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final newsId = message.data['newsId'];
  final title = message.notification?.title ?? 'News';
  final body = message.notification?.body ?? '';

  if (newsId != currentNewsId) {
    _showNotification(newsId, title, body);
  }
}

Future<void> _showNotification(
  String? newsId,
  String title,
  String body,
) async {
  if (newsId != null && newsId == currentNewsId) return;

  NotificationsScreen.savedNews.add(
    NewsArt(
      imgUrl:
          "https://img.freepik.com/free-vector/realistic-news-studio-background_52683-103246.jpg",
      newsCnt: body,
      newsdescrbtion: body,
      newsHead: title,
      newsurl: "https://news.google.com/home?hl=en-US&gl=US&ceid=US:en",
    ),
  );

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

    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final newsId = message.data['newsId'];
      final title = message.notification?.title ?? 'News';
      final body = message.notification?.body ?? '';
      _showNotification(newsId, title, body);
    });

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
