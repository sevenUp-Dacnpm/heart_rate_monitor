import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  final String note;
  const EditDialog({this.note, Key key}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController _textFieldController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textFieldController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Reminder Note'),
      content: TextField(
        controller: _textFieldController,
        autofocus: true,
        // decoration: InputDecoration(hintText: '$reminderNote'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context, _textFieldController.text);
          },
        ),
      ],
    );
  }
}
