import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/utils/statistic_calculator/statistic_calculator.dart';
import 'package:intl/intl.dart';

class DayTab extends StatefulWidget {
  final List<HeartRate> history;

  DayTab(this.history);
  @override
  _DayTabState createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
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
                      _date = _date.subtract(Duration(days: 1));
                    });
                  },
                  icon: Icon(Icons.chevron_left)),
              Expanded(
                  child: Text(
                "${DateFormat.yMMMMd().format(_date)}",
                textAlign: TextAlign.center,
              )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      var nextDay = _date.add(Duration(days: 1));
                      if (nextDay.compareTo(DateTime.now()) <= 0)
                        setState(() {
                          _date = nextDay;
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
                    interval: 3,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return '0h';
                        case 3:
                          return '3h';
                        case 6:
                          return '6h';
                        case 9:
                          return '9h';
                        case 12:
                          return '12h';
                        case 15:
                          return '15h';
                        case 18:
                          return '18h';
                        case 21:
                          return '21h';
                        case 24:
                          return '24h';
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
                barGroups: StatisticCalculator.statisticByDay(widget.history, _date),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
