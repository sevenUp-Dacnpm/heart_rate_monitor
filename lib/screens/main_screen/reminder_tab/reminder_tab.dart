import 'package:flutter/material.dart';

class ReminderTab extends StatefulWidget {
  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 150),
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date Time',
                    textAlign: TextAlign.start,
                  ),
                  Text('29/03/1999')
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Note',
                    textAlign: TextAlign.start,
                  ),
                  Text('Hello world')
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: null, child: Text('Cancel')),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF000000)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF84E0D4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                ))),
                    onPressed: () {},
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5), child: Text('Oke')),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
