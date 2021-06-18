import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/local_widgets/edit_dialog/edit_dialog.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_list.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'reminder_list.dart';

class ReminderTab extends StatefulWidget {
  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
  Reminder _reminder;

  void callDatePicker() async {
    var result = await getDate();
    if (result != null)
      setState(() {
        _reminder.time = result;
      });
    return null;
  }

  Future<DateTime> getDate() async {
    // Imagine that this function is
    // more complex and slow.
    var currentYear = DateTime.now().year;
    var currentMonth = DateTime.now().month;
    var currentDay = DateTime.now().day;
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(currentYear, currentMonth, currentDay),
      lastDate: DateTime(2030),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return EditDialog(
          note: _reminder.note,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _reminder.note = value;
        });
      }
    });
  }

  void handleEditNote() {
    _displayTextInputDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _reminder = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date Time',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '${DateFormat('yMd').add_jm().format(_reminder.time)}',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF84E0D4),
                  ),
                  onPressed: callDatePicker,
                  padding: EdgeInsets.zero,
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Note',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      _reminder.note,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(AppIcons.edit, color: Colors.black),
                  onPressed: handleEditNote,
                  padding: EdgeInsets.zero,
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   minVerticalPadding: 0,
                //   title: Text(
                //       '${DateFormat('yMd').add_jm().format(_reminder.time)}'),
                // )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.4,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFEEEEEE))),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headline4,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _reminder);
                      },
                      child: Text(
                        'Oke',
                        style: Theme.of(context).textTheme.headline4,
                      )),
                ],
              ),
            ),
          ],
        ),
        // child: Column(
        //   children: [
        //     Row(
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               //crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text('Date Time',
        //                     style: Theme.of(context).textTheme.headline4),
        //               ],
        //             ),
        //             SizedBox(
        //               height: screenSize.height * 0.05,
        //             ),
        //             Row(
        //               // crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'Note',
        //                   style: Theme.of(context).textTheme.headline4,
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           width: screenSize.width * 0.05,
        //         ),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               children: [
        //                 Text(
        //                     '${DateFormat('yMd').add_jm().format(_reminder.time)}'),
        //                 IconButton(
        //                     icon: Icon(
        //                       Icons.calendar_today_outlined,
        //                       color: Color(0xFF84E0D4),
        //                     ),
        //                     onPressed: callDatePicker)
        //               ],
        //             ),
        //             SizedBox(
        //               height: screenSize.height * 0.05,
        //             ),
        //             Row(
        //               children: <Widget>[
        //                 SizedBox(
        //                   width: 200,
        //                   child: Text(
        //                     _reminder.note,
        //                     overflow: TextOverflow.visible,
        //                   ),
        //                 ),
        //                 IconButton(
        //                     icon:
        //                         const Icon(AppIcons.edit, color: Colors.black),
        //                     onPressed: handleEditNote),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       height: screenSize.height * 0.4,
        //     ),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           ElevatedButton(
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //               style: ButtonStyle(
        //                   backgroundColor:
        //                       MaterialStateProperty.all(Color(0xFFEEEEEE))),
        //               child: Text(
        //                 'Cancel',
        //                 style: Theme.of(context).textTheme.headline4,
        //               )),
        //           ElevatedButton(
        //               onPressed: () {
        //                 Navigator.pop(context, _reminder);
        //               },
        //               child: Text(
        //                 'Oke',
        //                 style: Theme.of(context).textTheme.headline4,
        //               )),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      )),
    );
  }
}
