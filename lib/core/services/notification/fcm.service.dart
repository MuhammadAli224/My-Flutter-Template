import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../main.dart';
import '../../dependencies/dependencies_injection.dart';
import '../token/token_cubit.dart';
import 'awesome_notification.service.dart';

class FcmHelper {
  FcmHelper._();

  static late FirebaseMessaging messaging;
  static bool _initialized = false;

  static Future<void> initFcm() async {
    if (_initialized) return;
    _initialized = true;

    try {
      messaging = FirebaseMessaging.instance;

      await _setupFcmNotificationSettings();
      await _generateFcmToken();

      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);

      messaging.onTokenRefresh.listen(getIt<TokenCubit>().saveFcmToken);
    } catch (error) {
      logger.e(error);
    }
  }

  static Future<void> _setupFcmNotificationSettings() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  static Future<void> _generateFcmToken() async {
    try {
      final token = await messaging.getToken();
      if (token != null) {
        await getIt<TokenCubit>().saveFcmToken(token);
      }
      logger.d("FCM Token : $token");
    } catch (error) {
      logger.e(error);
    }
  }

  static Future<void> logout() async {
    try {
      await messaging.deleteToken();
    } catch (error) {
      logger.e(error);
    }
  }

  static void _fcmForegroundHandler(RemoteMessage message) {
    if (message.notification != null) {
      NotificationsController.createNewNotification(
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        bigPicture: '',
        payload: message.data.cast<String, String>(),
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    NotificationsController.createNewNotification(
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      bigPicture: '',
      payload: message.data.cast<String, String>(),
    );
  }
}
