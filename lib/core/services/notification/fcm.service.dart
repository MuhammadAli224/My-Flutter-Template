import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../main.dart';
// import '../../constant/firebase_topic.dart';
import 'awesome_notification.service.dart';

class FcmHelper {
  FcmHelper._();

  static late FirebaseMessaging messaging;

  static Future<void> initFcm() async {
    try {
      messaging = FirebaseMessaging.instance;

      await _setupFcmNotificationSettings();

      await _generateFcmToken();
      // await messaging.subscribeToTopic(FirebaseTopic.all);
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
    } catch (error) {
      logger.e(error);
    }
  }

  static Future<void> _setupFcmNotificationSettings() async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  static Future<void> _generateFcmToken() async {
    try {

      String? token;
      if (Platform.isAndroid) {
        token = await messaging.getToken();
      } else if (Platform.isIOS) {
        token = await messaging.getAPNSToken();
      }
      logger.w("FCM Token : $token");
    } catch (error) {
      logger.e(error);
    }
  }

  // static _sendFcmTokenToServer() {
  //   getIt<AppServices>().appBox.get(BoxKey.firebaseToken);
  // }

  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    _handleNotification(message);
  }

  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    _handleNotification(message);
  }

  static void _handleNotification(RemoteMessage message) {
    if (message.notification != null) {
      NotificationsController.createNewNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          bigPicture: '',
          payload: message.data.cast<String, String>());
    }
  }
}