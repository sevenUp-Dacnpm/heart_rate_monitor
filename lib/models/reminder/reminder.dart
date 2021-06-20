import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_service/reminder_service.dart';

class Reminder {
  DateTime date;
  TimeOfDay time;
  String note;
  int id;

  Reminder({this.date, this.time, this.note, this.id});

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
      date: DateTime.parse(json["date"]),
      time: TimeOfDay(
          hour: int.parse(json["time"].split(":")[0]),
          minute: int.parse(json["time"].split(":")[1])),
      note: json["note"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "time": formatTimeOfDay(time),
        "note": note,
      };
}
