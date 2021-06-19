import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_detail.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}

class Reminder {
  DateTime time;
  String note;

  Reminder(this.time, this.note);
}

class _ReminderListState extends State<ReminderList> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {}

  List<Reminder> arrData = [
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
  ];

  ListView _buildWidgetList() {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        padding: const EdgeInsets.all(40),
        itemCount: arrData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('yMd')
                            .add_jm()
                            .format(arrData[index].time)
                            .toString(),
                        style: TextStyle(fontSize: 20)),
                    IconButton(
                        icon: const Icon(AppIcons.edit, color: Colors.black),
                        onPressed: () {
                          Navigator.pushNamed(context, "/reminder_detail",
                                  arguments: arrData[index])
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                arrData[index] = value;
                              });
                            }
                          });
                        }),
                    IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            arrData.removeAt(index);
                          });
                        }),
                  ],
                ),
                Text(
                  arrData[index].note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
      ),
      body: Container(
        child: _buildWidgetList(),
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
          Navigator.pushNamed(context, "/reminder_detail").then((value) {
            if (value != null) {
              setState(() {
                arrData.add(value);
              });
            }
          })
        },
      ),
    );
  }
}
