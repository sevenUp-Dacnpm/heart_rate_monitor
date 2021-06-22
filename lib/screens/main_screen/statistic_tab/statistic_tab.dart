import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/screens/main_screen/statistic_tab/local_widget/day_tab/day_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/statistic_tab/local_widget/month_tab/month_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/statistic_tab/local_widget/week_tab/week_tab.dart';
import 'package:heart_rate_monitor/services/api_services/heart_rate_services/heart_rate_services.dart';
import 'package:heart_rate_monitor/services/sqlite_services/sqlite_services.dart';

class StatisticTab extends StatefulWidget {
  const StatisticTab({Key key}) : super(key: key);

  @override
  _StatisticTabState createState() => _StatisticTabState();
}

class _StatisticTabState extends State<StatisticTab> {
  List<HeartRate> _history = [];

  Future<void> loadData() async {
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
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Statistic"),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              labelColor: Color(0xFF2CC6AE),
              unselectedLabelColor: DefaultTextStyle.of(context).style.color,
              tabs: [
                Tab(
                  text: "Day",
                ),
                Tab(
                  text: "Week",
                ),
                Tab(
                  text: "Month",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DayTab(_history),
              WeekTab(_history),
              MonthTab(_history),
            ],
          )),
    );
  }
}
