import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticTab extends StatefulWidget {
  @override
  _StatisticTabState createState() => _StatisticTabState();
}

class _StatisticTabState extends State<StatisticTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistic'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
