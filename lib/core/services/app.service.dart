import '../../global_imports.dart';
class AppServices {
  Future<void> initAppServices() async {
    // OneSignal.Debug.setLogLevel(OSLogLevel.warn);
    // OneSignal.initialize("859c8631-4529-4786-8658-7134daad2adb");
    // OneSignal.Notifications.requestPermission(false);

    Future.wait(
      [
        ScreenUtil.ensureScreenSize(),
      ],
    );

    // await FcmHelper.initFcm();
    // await NotificationsController.initializeLocalNotifications();
    // await NotificationsController.initializeIsolateReceivePort();
    // NotificationsController.startListeningNotificationEvents();
  }
}
