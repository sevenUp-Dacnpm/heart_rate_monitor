import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.Hm();
  return format.format(dt);
}

// DateTime timeOfDayToDateTime(TimeOfDay tod) {
//   final now = new DateTime.now();
//   final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
//   return dt;
// }

int dateTimeToTimestamp(DateTime dateTime) {
  var timeStamp = dateTime.toUtc().millisecondsSinceEpoch;
  return timeStamp;
}

DateTime createDateFromDateTimeAndTimeOfDay(
    DateTime dateTime, TimeOfDay timeOfDay) {
  final dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
      timeOfDay.hour, timeOfDay.minute);
  return dt;
}

int durationTime(DateTime dateTime, TimeOfDay timeOfDay) {
  DateTime now = DateTime.now();
  DateTime reminderDate =
      createDateFromDateTimeAndTimeOfDay(dateTime, timeOfDay);
  int nowTimestamp = dateTimeToTimestamp(now);
  int reminderTimestamp = dateTimeToTimestamp(reminderDate);

  var result = ((reminderTimestamp - nowTimestamp) / 1000).round();
  return result;
}
