import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ReminderTab extends StatefulWidget {
  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
 var finaldate = DateFormat('yMd').add_jm().format(DateTime.now());
  void callDatePicker() async {
    var order = await getDate();
    setState(() {
        finaldate =DateFormat('yMd').add_jm().format(order??=DateTime.now());
    });
    return null;
  }

  Future<DateTime?> getDate() {
    // Imagine that this function is
    // more complex and slow.
    var currentYear = DateTime.now().year;
    var currentMonth = DateTime.now().month;
    var currentDay = DateTime.now().day;
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(currentYear,currentMonth, currentDay),
      lastDate: DateTime(2030),
      // builder: (BuildContext context, Widget? child) {
      // return Theme(
      // data: ThemeData.light(),
      // child: child
      // );
      // },
    );
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
                          children: [
                            Text('Date Time',
                                style: Theme.of(context).textTheme.headline4),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Row(
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
                      width: screenSize.width * 0.1,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Hello every one',)
                            // Row(
                            //   children: <Widget>[
                            //     //Expanded(child: Text('đffầdfá')),
                            //     //Text('Hello every one',)
                            //     // TextField(
                            //     //   //maxLines: 8,
                            //     //   decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
                            //     // ),
                            //   ],
                            // ),
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
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF000000)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF5F5F5)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      child: Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.headline4,
                          )),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF000000)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF84E0D4)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      onPressed: () {},
                      child: Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            'Oke',
                            style: Theme.of(context).textTheme.headline4,
                          )),
                    )
                  ],
                )
              ],
            ),
          ))
    );
  }
}
