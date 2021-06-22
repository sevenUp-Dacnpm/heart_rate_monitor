import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/reminder/reminder.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_service/reminder_service.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'package:heart_rate_monitor/services/sqlite_services/sqlite_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  bool _isLoading = true;
  List<Reminder> _reminderList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    var result = await SqliteServices.getReminderList();
    print(result.length);
    setState(() {
      _reminderList.addAll(result);
      _isLoading = false;
    });
  }

  Future<void> saveReminder(Reminder reminder) async {
    await SqliteServices.saveReminder(reminder);
  }

  Future<void> updateReminder(Reminder reminder, int index) async {
    await SqliteServices.updateReminder(reminder, index);
  }

  Future<void> deleteReminder(int index) async {
    await SqliteServices.deleteReminder(index);
  }

  List<Reminder> arrData = [
    Reminder(
        date: DateTime.now(), time: TimeOfDay.now(), note: "Mark heart rate!"),
    Reminder(
        date: DateTime.now(), time: TimeOfDay.now(), note: "Mark heart rate!"),
    Reminder(
        date: DateTime.now(), time: TimeOfDay.now(), note: "Mark heart rate!"),
    Reminder(
        date: DateTime.now(), time: TimeOfDay.now(), note: "Mark heart rate!"),
  ];

  ListView _buildWidgetList() {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        padding: const EdgeInsets.all(40),
        itemCount: _reminderList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                            '${DateFormat('yMd').format(_reminderList[index].date)} '
                            '- ${formatTimeOfDay(_reminderList[index].time)}',
                            style: TextStyle(fontSize: 15)),
                      ],
                    )),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(AppIcons.edit,
                                  color: Colors.black),
                              onPressed: () {
                                Navigator.pushNamed(context, "/reminder_detail",
                                        arguments: _reminderList[index])
                                    .then((value) {
                                  if (value != null) {
                                    updateReminder(
                                        value, _reminderList[index].id);
                                    setState(() {
                                      _reminderList[index] = value;
                                    });
                                  }
                                });
                              },
                              padding: EdgeInsets.only(top: 25),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                deleteReminder(_reminderList[index].id);
                                setState(() {
                                  _reminderList.removeAt(index);
                                });
                              },
                              padding: EdgeInsets.only(top: 25),
                            ),
                          ],
                        ))
                  ],
                ),
                Text(
                  _reminderList[index].note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder List'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildWidgetList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: Color(0xFF5CC6BC),
        ),
        label: const Text(
          'Create',
          style: TextStyle(
            color: Color(0xFF5CC6BC),
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () => {
          Navigator.pushNamed(
            context,
            "/reminder_detail",
            arguments:
                Reminder(date: DateTime.now(), time: TimeOfDay.now(), note: ''),
          ).then((value) {
            if (value != null) {
              setState(() {
                _reminderList.add(value);
              });
              saveReminder(value);
            }
          })
        },
      ),
    );
  }
}
