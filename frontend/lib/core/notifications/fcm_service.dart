import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initializeFCM() async {
    // 알림 권한 요청
    await _firebaseMessaging.requestPermission();

    // FCM 토큰 확인
    final token = await _firebaseMessaging.getToken();
    print("FCM Token: $token"); // Django 서버에 저장 필요

    // Foreground 알림 설정
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _localNotifications.initialize(initSettings);

    // Foreground 메시지 리스너
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(
          message.notification!.title ?? "알림",
          message.notification!.body ?? "",
        );
      }
    });

    // Background 클릭 이벤트 리스너
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("알림 클릭: ${message.data}");
    });
  }

  static Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_channel',
      '푸시 알림',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);
    await _localNotifications.show(0, title, body, notificationDetails);
  }
}