import 'package:flutter/material.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}

class Reminder{
  DateTime time;
  String note;
  
  Reminder(this.time, this.note);
}

class _ReminderListState extends State<ReminderList> {
  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData(){
  }
  
  List<Reminder> arrData=[
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
    Reminder(DateTime.now(), "Mark heart rate!"),
  ];
  
  ListView _buildWidgetList(){
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        padding: const EdgeInsets.all(40),
        itemCount: arrData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(arrData[index].time.toString(),
                        style: TextStyle(fontSize: 10)),
                    FloatingActionButton(
                        onPressed: null,
                        child: const Icon(Icons.edit),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: screenSize.height * 0.015,
                // ),
                Row(
                  children: [
                    Text(arrData[index].note,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        // fontFamily:
                      ),),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _buildWidgetList()
    );
  }
}
