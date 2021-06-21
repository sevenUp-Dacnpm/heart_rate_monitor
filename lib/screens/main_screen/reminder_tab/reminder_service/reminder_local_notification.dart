import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin initializeNotification() {
  FlutterLocalNotificationsPlugin localNotification;
  var androidInitialize = new AndroidInitializationSettings('ic_launcher');
  var iOSInitialize = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      android: androidInitialize, iOS: iOSInitialize);
  localNotification = new FlutterLocalNotificationsPlugin();
  localNotification.initialize(initializationSettings);
  return localNotification;
}

Future showNotification(FlutterLocalNotificationsPlugin localNotification,
    DateTime dateTime, String note) async {
  var androidDetails = new AndroidNotificationDetails(
      "channelId", "Local Notification", "Description of notification",
      importance: Importance.max);
  var iosDetails = new IOSNotificationDetails();
  var generalNotificationDetails =
      new NotificationDetails(android: androidDetails, iOS: iosDetails);
  // await localNotification.show(
  //     0, "Heart Rate Reminder", note, generalNotificationDetails);

  localNotification.schedule(
      0, "Heart Rate Reminder", note, dateTime, generalNotificationDetails);
}
