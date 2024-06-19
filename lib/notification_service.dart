import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('img');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  Future<void> scheduleRepeatingNotifications(int intervalleNotif) async {
    var androidDetails = const AndroidNotificationDetails(
      'repeating_channel_id',
      'repeating_channel_name',
      importance: Importance.max,
    );

    var iosDetails = const DarwinNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await notificationsPlugin.periodicallyShow(
      0,
      'Rappel de boire de l\'eau',
      'N\'oubliez pas de boire de l\'eau régulièrement.',
      RepeatInterval.everyMinute, // Changez cela à RepeatInterval.hourly pour des tests
      platformDetails,
    );
  }

  Future<void> cancelNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
