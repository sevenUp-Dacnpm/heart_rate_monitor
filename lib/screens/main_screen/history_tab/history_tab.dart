import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class History{
  int heartRate;
  DateTime time;
}

class _HistoryTabState extends State<HistoryTab> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final data = <String, String>{};
  final arrData = List<History>[

  ]

  ListView _buildWidgetList(){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
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
