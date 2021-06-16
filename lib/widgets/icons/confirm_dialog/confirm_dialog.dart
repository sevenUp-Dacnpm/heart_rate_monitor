import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String _message;

  ConfirmDialog(this._message);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 24, top: 30, right: 24, bottom: 20),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.only(right: 10, bottom: 20),
      insetPadding: EdgeInsets.all(25),
      content: Container(
        width: screenSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_message),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFEEEEEE))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        )
      ],
    );
  }
}
