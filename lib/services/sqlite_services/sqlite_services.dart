import 'package:heart_rate_monitor/models/heart_rate_model/body_state.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/models/reminder/reminder.dart';
import 'package:sqflite/sqflite.dart';

class SqliteServices {
  static Database database;
  static Future<void> initSqlite() async {
    database = await openDatabase("heart_rate_db.db", onCreate: (db, version) {
      db.execute(
          "CREATE TABLE HeartRate (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, heartRate INTEGER NOT NULL, note TEXT, state TEXT NOT NULL)");
      db.execute(
          "CREATE TABLE Reminder(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, time TEXT NOT NULL, note TEXT)");
    }, version: 1);
  }

  static Future<void> saveHeartRate(HeartRate heartRate) async {
    await database.transaction((txn) async {
      await txn.insert("HeartRate", {
        "date": DateTime.now().toIso8601String(),
        "heartRate": heartRate.heartRate,
        "note": heartRate.note,
        "state": heartRate.bodyState.toString(),
      });
      return;
    });
  }

  static Future<List<HeartRate>> getHeartRateHistory() async {
    var json = await database.query("HeartRate");
    return List<HeartRate>.from(json.map((e) => HeartRate.fromJson(e)));
  }

  //======================Reminder==========================================
  static Future<void> saveReminder(Reminder reminder) async {
    await database.transaction((txn) async {
      await txn.insert("Reminder", reminder.toJson());
      return;
    });
  }

  static Future<void> updateReminder(Reminder reminder, int index) async {
    await database.transaction((txn) async {
      int count = await txn.update("Reminder", reminder.toJson(),
          where: 'id = ?', whereArgs: [index]);
      return;
    });
  }

  static Future<void> deleteReminder(int index) async {
    await database.transaction((txn) async {
      await txn.delete("Reminder", where: 'id = ?', whereArgs: [index]);
      return;
    });
  }

  static Future<List<Reminder>> getReminderList() async {
    var json = await database.query("Reminder");
    return List<Reminder>.from(json.map((e) => Reminder.fromJson(e)));
  }
}
