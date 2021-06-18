import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/body_state.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/services/api_services/heart_rate_services/heart_rate_services.dart';
import 'package:heart_rate_monitor/services/sqlite_services/sqlite_services.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';

class SaveDialog extends StatefulWidget {
  const SaveDialog({Key key, this.bpm}) : super(key: key);

  final int bpm;

  @override
  _SaveDialogState createState() => _SaveDialogState();
}

class _SaveDialogState extends State<SaveDialog> {
  BodyState _bodyState = BodyState.routine;
  bool _isSaving = false;
  bool _isFailed = false;
  var _textController = TextEditingController();
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
            Text(
              "${widget.bpm} BPM",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  AppIcons.edit,
                ),
                hintText: "Note",
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      horizontalTitleGap: 0,
                      title: Text("Routine"),
                      leading: Radio<BodyState>(
                        value: BodyState.routine,
                        groupValue: _bodyState,
                        onChanged: (BodyState value) {
                          setState(() {
                            _bodyState = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      horizontalTitleGap: 0,
                      title: Text("Exercise"),
                      leading: Radio<BodyState>(
                        value: BodyState.exercise,
                        groupValue: _bodyState,
                        onChanged: (BodyState value) {
                          setState(() {
                            _bodyState = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isSaving)
              Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            if (_isFailed)
              Text(
                "Save failed",
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            if (_isSaving || _isFailed) SizedBox(height: 20)
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text(
                "Ignore",
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFEEEEEE))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
                setState(() {
                  _isSaving = true;
                  _isFailed = false;
                });
                var heartRate = HeartRate(heartRate: widget.bpm, bodyState: _bodyState, note: _textController.text);
                if (AccessData().token != null) {
                  var result = await HeartRateServices.saveHeartRate(heartRate);
                  if (result) {
                    Navigator.of(context).pop({"result": true, "bodyState": _bodyState});
                  } else {
                    setState(() {
                      _isFailed = true;
                    });
                  }
                } else {
                  await SqliteServices.saveHeartRate(heartRate);
                  Navigator.of(context).pop({"result": true, "bodyState": _bodyState});
                }
                setState(() {
                  _isSaving = false;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
