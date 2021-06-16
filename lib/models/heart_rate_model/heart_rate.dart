class HeartRate {
  HeartRate({
    this.date,
    this.id,
    this.userId,
    this.heartRate,
    this.v,
  });

  DateTime date;
  String id;
  String userId;
  int heartRate;
  int v;

  factory HeartRate.fromJson(Map<String, dynamic> json) => HeartRate(
        date: DateTime.parse(json["date"]),
        id: json["_id"],
        userId: json["userId"],
        heartRate: json["heartRate"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "_id": id,
        "userId": userId,
        "heartRate": heartRate,
        "__v": v,
      };
}
