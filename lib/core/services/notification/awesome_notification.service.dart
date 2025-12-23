import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../constant/notification_channel.dart';
import '../../core.dart';
import '../../model/notification_channel_model.dart';

class NotificationsController {
  static ReceivedAction? initialAction;

  // ***************************************************************
  //    INITIALIZATIONS
  // ***************************************************************
  static Future<void> initializeLocalNotifications() async {
    await initializeIsolateReceivePort();
    await AwesomeNotifications().initialize(
      "resource://drawable/app_logo",
      [
        NotificationChannel(
          channelGroupKey: NotificationChannelKey.basicChannel.groupKey,
          channelKey: NotificationChannelKey.basicChannel.key,
          channelName: NotificationChannelKey.basicChannel.name,
          channelDescription: NotificationChannelKey.basicChannel.description,
          defaultColor: AppColor.primaryColor,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelGroupKey: NotificationChannelKey.basicChannel.groupKey,
          channelKey: NotificationChannelKey.basicChannel.key,
          channelName: 'Badge indicator notifications',
          channelDescription:
          'Notification channel to activate badge indicator',
          channelShowBadge: true,
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.yellow,
        ),
        NotificationChannel(
          channelGroupKey: NotificationChannelKey.categoryChannel.groupKey,
          channelKey: NotificationChannelKey.categoryChannel.key,
          channelName: NotificationChannelKey.categoryChannel.name,
          channelDescription:
          NotificationChannelKey.categoryChannel.description,
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
        ),
        NotificationChannel(
          channelGroupKey: NotificationChannelKey.categoryChannel.groupKey,
          channelKey: NotificationChannelKey.alarmChannel,
          channelName: 'Alarms Channel',
          channelDescription: 'Channel with alarm ringtone',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
        ),
        NotificationChannel(
          channelGroupKey: NotificationChannelKey.scheduleChannel.groupKey,
          channelKey: NotificationChannelKey.scheduleChannel.key,
          channelName: NotificationChannelKey.scheduleChannel.name,
          channelDescription:
          NotificationChannelKey.scheduleChannel.description,
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          vibrationPattern: lowVibrationPattern,
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic',
          channelGroupName: 'Basic',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'category',
          channelGroupName: 'Category',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'schedule',
          channelGroupName: 'Schedule',
        ),
      ],
      debug: true,
    );
    // Get initial notification action is optional
    initialAction = await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: false,
    );
  }

  static Future<void> initializeNotificationsEventListeners() async {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationsController.onActionReceivedMethod,
      onNotificationCreatedMethod:
      NotificationsController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
      NotificationsController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
      NotificationsController.onDismissActionReceivedMethod,
    );
  }

  // ***************************************************************
  //    ON ACTION EVENT REDIRECTION TO MAIN ISOLATE
  // ***************************************************************

  static ReceivePort? receivePort;

  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate');
    receivePort!.listen((serializedData) {
      final receivedAction = ReceivedAction().fromMap(serializedData);
      onActionReceivedMethodImpl(receivedAction);
    });

    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      'notification_action_port',
    );
  }

  // ***************************************************************
  //    NOTIFICATIONS EVENT LISTENERS
  // ***************************************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification,
      ) async {
    var message =
        'Notification created on ${receivedNotification.createdLifeCycle?.name}';
    logger.d(message);
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification,
      ) async {
    var message1 =
        'Notification displayed on ${receivedNotification.displayedLifeCycle?.name}';
    var message2 =
        'Notification displayed at ${receivedNotification.displayedDate}';

    logger.d(message1);
    logger.d(message2);
    logger.d(receivedNotification.toMap());
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction,
      ) async {
    var message =
        'Notification dismissed on ${receivedAction.dismissedLifeCycle?.name}';
    logger.w(message);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction,
      ) async {
    if (receivePort != null) {
      await onActionReceivedMethodImpl(receivedAction);
    } else {
      logger.d(
        'onActionReceivedMethod was called inside a parallel dart isolate, where receivePort was never initialized.',
      );
      SendPort? sendPort = IsolateNameServer.lookupPortByName(
        'notification_action_port',
      );

      if (sendPort != null) {
        logger.d(
          'Redirecting the execution to main isolate process in listening...',
        );
        dynamic serializedData = receivedAction.toMap();
        sendPort.send(serializedData);
      }
    }
  }

  static Future<void> onActionReceivedMethodImpl(
      ReceivedAction receivedAction,
      ) async {
    var message =
        'Action ${receivedAction.actionType?.name} received on ${receivedAction.actionLifeCycle?.name}';
    logger.d(message);

    // Always ensure that all plugins was initialized
    WidgetsFlutterBinding.ensureInitialized();

    // if (receivedAction.buttonKeyPressed == AppStrings.call) {
    //   // launchCall(receivedAction.payload!['phone']!);
    // }
    // if (receivedAction.buttonKeyPressed == AppStrings.navigateToStore) {
    //   launchMap(
    //       latitude: double.parse(receivedAction.payload!['lat']!),
    //       longitude: double.parse(receivedAction.payload!['lon']!));
    // }

    // bool isSilentAction =
    //     receivedAction.actionType == ActionType.SilentAction ||
    //         receivedAction.actionType == ActionType.SilentBackgroundAction;

    // SilentBackgroundAction runs on background thread and cannot show
    // UI/visual elements
    // if (receivedAction.actionType != ActionType.SilentBackgroundAction) {
    //   SmartDialog.showToast(
    //     '${isSilentAction ? 'Silent action' : 'Action'}'
    //     ' received on ${receivedAction.actionLifeCycle?.name}',
    //   );
    // }

    // switch (receivedAction.channelKey) {
    //   case 'call_channel':
    //     if (receivedAction.actionLifeCycle !=
    //         NotificationLifeCycle.Terminated) {
    //       await receiveCallNotificationAction(receivedAction);
    //     }
    //     break;
    //
    //   case 'alarm_channel':
    //     await receiveAlarmNotificationAction(receivedAction);
    //     break;
    //
    //   case 'media_player':
    //     await receiveMediaNotificationAction(receivedAction);
    //     break;
    //
    //   case 'chats':
    //     await receiveChatNotificationAction(receivedAction);
    //     break;
    //
    //   default:
    //     if (isSilentAction) {
    //       debugPrint(receivedAction.toString());
    //       debugPrint("start");
    //       await Future.delayed(const Duration(seconds: 4));
    //       // final url = Uri.parse("http://google.com");
    //       // final re = await http.get(url);
    //       // debugPrint(re.body);
    //       // debugPrint("long task done");
    //       break;
    //     }
    //     if (!AwesomeStringUtils.isNullOrEmpty(receivedAction.buttonKeyInput)) {
    //       receiveButtonInputText(receivedAction);
    //     } else {
    //       receiveStandardNotificationAction(receivedAction);
    //     }
    //     break;
    // }
  }

  // ***************************************************************
  //    NOTIFICATIONS HANDLING METHODS
  // ***************************************************************

  static Future<void> interceptInitialCallActionRequest() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction();

    if (receivedAction?.channelKey == 'call_channel') {
      initialAction = receivedAction;
    }
  }

  //  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createNewNotification({
    required String title,
    required String body,
    String? bigPicture,
    NotificationChannelModel? channel,
    required Map<String, String?> payload,
  }) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        handleNotificationPayload(GlobalContext.context, payload.cast());

        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: -1,
            // -1 is replaced by a random number
            channelKey: channel?.key ?? NotificationChannelKey.basicChannel.key,
            title: title,
            body: body,
            wakeUpScreen: true,
            bigPicture: bigPicture,
            roundedLargeIcon: true,
            largeIcon: "asset://${Assets.imagesAppNewIcon}",
            notificationLayout: NotificationLayout.BigPicture,
            payload: payload,
          ),
        );
      }
    });
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required int id,
    required DateTime date,
    Map<String, String?>? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        title: title,
        body: body,
        wakeUpScreen: true,
        autoDismissible: false,
        category: NotificationCategory.Reminder,
        groupKey: NotificationChannelKey.scheduleChannel.groupKey,
        channelKey: NotificationChannelKey.scheduleChannel.key,
        payload: payload,
      ),
      schedule:
      NotificationCalendar
      // .fromDate(
      // date: date, allowWhileIdle: true, preciseAlarm: true));
        (
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
        second: date.second,
        allowWhileIdle: true,
        preciseAlarm: true,
        repeats: true,
      ),
      actionButtons: [
        // NotificationActionButton(
        //   key: AppStrings.navigateToStore,
        //   label: AppStrings.navigateToStore,
        // ),
        // NotificationActionButton(
        //   key: AppStrings.call,
        //   label: AppStrings.call,
        //   color: Colors.green,
        // ),
      ],
    );
  }

  static void handleNotificationPayload(
      BuildContext context,
      Map<String, dynamic> payload,
      ) {
    // final notificationCubit = context.read<NotificationsCubit>();
    //
    // final notificationModel = NotificationPayloadModel.fromJson(payload);

    // notificationCubit.addNotification(notificationModel);

    // switch (notificationModel.topic) {
    //   case 'new_reservation':
    //     // context.read<TodayReservationCubit>().getTodayReservation();
    //     context.read<TodayReservationCubit>().clearAndFetchReservations();
    //     break;
    // }
  }

  static Future<void> cancelScheduleNotification({required int id}) async {
    await AwesomeNotifications().cancelSchedule(id);
  }

  static Future<void> cancelAllScheduleNotification() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  static Future<void> getAllScheduleNotifications() async {
    List<NotificationModel> allScheduleNotifications =
    await AwesomeNotifications().listScheduledNotifications();
    logger.e(allScheduleNotifications.length);
    logger.e("Scheduled Notifications :$allScheduleNotifications");
  }
}
