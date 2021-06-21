import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

FlutterLocalNotificationsPlugin initializeNotification(selectNotification) {
  FlutterLocalNotificationsPlugin localNotification;
  var androidInitialize = new AndroidInitializationSettings('ic_launcher');
  var iOSInitialize = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      android: androidInitialize, iOS: iOSInitialize);
  localNotification = new FlutterLocalNotificationsPlugin();
  localNotification.initialize(initializationSettings,
      onSelectNotification: selectNotification);
  return localNotification;
}

Future showNotification(FlutterLocalNotificationsPlugin localNotification,
    DateTime dateTime, String note) async {
  var androidDetails = new AndroidNotificationDetails(
      "channelId", "Local Notification", "Description of notification",
      importance: Importance.max, priority: Priority.high);
  var iosDetails = new IOSNotificationDetails();
  var generalNotificationDetails =
      new NotificationDetails(android: androidDetails, iOS: iosDetails);

  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  await localNotification.zonedSchedule(0, "Heart Rate Reminder", note,
      tz.TZDateTime.from(dateTime, tz.local), generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
