import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/services/api_services/heart_rate_services/heart_rate_services.dart';
import 'package:heart_rate_monitor/services/sqlite_services/sqlite_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  bool _isLoading = true;
  List<HeartRate> _history = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    if (AccessData().token == null) {
      var history = await SqliteServices.getHeartRateHistory();
      print(history.length);
      setState(() {
        _history.addAll(history);
      });
    } else {
      var history = await HeartRateServices.getHeartRateHistory();
      print(history.length);
      setState(() {
        _history.addAll(history);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(40),
            itemCount: _history.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_history[index].heartRate.toString(), style: Theme.of(context).textTheme.headline3),
                        Text(DateFormat('yMd').add_jm().format(_history[index].date).toString()),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.015,
                    ),
                    Row(
                      children: [
                        Text(
                          _history[index].note ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Laila",
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                  ],
                ),
              );
            });
  }
}
