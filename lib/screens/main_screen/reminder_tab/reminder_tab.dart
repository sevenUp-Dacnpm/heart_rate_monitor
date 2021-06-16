import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ReminderTab extends StatefulWidget {
  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
  var finaldate = DateFormat('yMd').add_jm().format(DateTime.now());
  var reminderNote = 'Hello world';

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = DateFormat('yMd').add_jm().format(order ??= DateTime.now());
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

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Reminder Note'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                print(_textFieldController.text);
                setState(() {
                  reminderNote = _textFieldController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void handleEditNote(){
    _displayTextInputDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(

        child: Container(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
              top: screenSize.height * 0.2,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date Time', style: Theme.of(context).textTheme.headline4),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.05,
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Note',
                                style: Theme.of(context).textTheme.headline4,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenSize.width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('$finaldate'),
                              IconButton(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xFF84E0D4),
                                  ),
                                  onPressed: callDatePicker)
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.05,
                          ),
                          Row(
                            children: <Widget>[
                              Text('$reminderNote',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                  icon: const Icon(AppIcons.edit,
                                      color: Colors.black),
                                  onPressed: handleEditNote)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5F5F5)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.headline4,
                            )),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF000000)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF84E0D4)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        onPressed: () {},
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Text(
                              'Oke',
                              style: Theme.of(context).textTheme.headline4,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
