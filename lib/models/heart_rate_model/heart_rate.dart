import 'package:heart_rate_monitor/models/heart_rate_model/body_state.dart';

class HeartRate {
  HeartRate({
    this.date,
    this.id,
    this.userId,
    this.heartRate,
    this.note,
    this.bodyState,
    this.v,
  });

  DateTime date;
  String id;
  String userId;
  int heartRate;
  String note;
  BodyState bodyState;
  int v;

  factory HeartRate.fromJson(Map<String, dynamic> json) => HeartRate(
        date: DateTime.parse(json["date"]),
        id: json["_id"] ?? json["id"].toString(),
        userId: json["userId"],
        heartRate: json["heartRate"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "createDate": date?.toIso8601String(),
        "_id": id,
        "userId": userId,
        "heartRate": heartRate,
        "note": note,
        "state": bodyState.toString(),
        "__v": v,
      };
}
