import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    const androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _notifications.initialize(initializationSettings);
  }

  static Future _notificationDetail() async => const NotificationDetails(
          android: AndroidNotificationDetails(
        'Gün Sayacı',
        'Merhaba',
        importance: Importance.max,
      ));

  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetail(),
          payload: payload);
 
  static Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDateTime,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduleDateTime, tz.local),
          await _notificationDetail(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.alarmClock);

  static Future showPeriodicNotifications({
      int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Your Chanel Name',
      'Your channel descriptio',
      channelDescription: 'description',
      importance: Importance.max,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = 
    NotificationDetails(
      android: androidNotificationDetails,
    );
    await _notifications.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails
    );
  }

  static Future scheduleDailyNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
}) async {
  // Gelecek gece 00:00'ı hesaplayın
  DateTime now = DateTime.now();
  DateTime nextMidnight = DateTime(now.year, now.month, now.day+1, 0, 0);

  await scheduleNotification(
    id: id,
    title: title,
    body: body,
    payload: payload,
    scheduleDateTime: nextMidnight,
  );
}

  static Future unScheduleAllNotifications() => _notifications.cancelAll();
}
