import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/utils/statistic_calculator/statistic_calculator.dart';
import 'package:intl/intl.dart';

class WeekTab extends StatefulWidget {
  final List<HeartRate> history;

  WeekTab(this.history);

  @override
  _WeekTabState createState() => _WeekTabState();
}

class _WeekTabState extends State<WeekTab> {
  DateTime weekStart;
  DateTime weekend;

  @override
  void initState() {
    super.initState();
    var today = DateTime.now();
    weekStart = DateTime(today.year, today.month, today.day - today.weekday + 1);
    weekend = DateTime(today.year, today.month, today.day - today.weekday + 7, 23, 59, 59, 999, 999);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      weekend = weekend.subtract(Duration(days: 7));
                      weekStart = weekStart.subtract(Duration(days: 7));
                    });
                  },
                  icon: Icon(Icons.chevron_left)),
              Expanded(
                  child: Text(
                "${DateFormat.yMMMMd().format(weekStart)} - ${DateFormat.yMMMMd().format(weekend)}",
                textAlign: TextAlign.center,
              )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      setState(() {
                        var today = DateTime.now();
                        if (today.compareTo(weekend) <= 0 && today.compareTo(weekStart) > 0) return;
                        weekend = weekend.add(Duration(days: 7));
                        weekStart = weekStart.add(Duration(days: 7));
                      });
                    });
                  },
                  icon: Icon(Icons.chevron_right)),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 140,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
                    tooltipMargin: 8,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.y.round().toString(),
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) =>
                        const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                    margin: 20,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 1:
                          return 'Mon';
                        case 2:
                          return 'Tue';
                        case 3:
                          return 'Wed';
                        case 4:
                          return 'Thu';
                        case 5:
                          return 'Fri';
                        case 6:
                          return 'Sat';
                        case 7:
                          return 'Sun';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    getTextStyles: (value) => TextStyle(
                        color: value <= 40
                            ? Color(0xff7589a2)
                            : value <= 80
                                ? Colors.green
                                : value <= 100
                                    ? Colors.amber
                                    : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: StatisticCalculator.statisticByWeek(widget.history, weekStart, weekend),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
