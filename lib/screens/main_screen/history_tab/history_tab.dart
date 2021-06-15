import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class History{
  int heartRate;
  DateTime time;
  String note;

  History(this.heartRate, this.time, this.note);
}

class _HistoryTabState extends State<HistoryTab> {
  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData(){

  }

  List<History> arrData = [
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
    History(80, DateTime.now(), 'hello'),
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
                      Text(arrData[index].heartRate.toString(),
                      style: Theme.of(context).textTheme.headline3),
                      Text(arrData[index].time.toString()),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.015,
                ),
                Row(
                  children: [
                    Text(arrData[index].note,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Laila",
                    ),),
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
