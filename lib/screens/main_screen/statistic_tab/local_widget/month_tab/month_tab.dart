import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/utils/statistic_calculator/statistic_calculator.dart';
import 'package:intl/intl.dart';

class MonthTab extends StatefulWidget {
  final List<HeartRate> history;

  MonthTab(this.history);

  @override
  _MonthTabState createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {
  DateTime beginningDayOfMonth;
  DateTime endingDayOfMonth;

  @override
  void initState() {
    super.initState();
    var today = DateTime.now();
    beginningDayOfMonth = DateTime(today.year, today.month, 1);
    endingDayOfMonth = DateTime(today.year, today.month + 1, 1).subtract(Duration(microseconds: 1));
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
                      endingDayOfMonth = DateTime(endingDayOfMonth.year, endingDayOfMonth.month, 1)
                          .subtract(Duration(microseconds: 1));
                      beginningDayOfMonth = DateTime(beginningDayOfMonth.year, beginningDayOfMonth.month - 1, 1);
                    });
                  },
                  icon: Icon(Icons.chevron_left)),
              Expanded(
                  child: Text(
                "${DateFormat.yMMMMd().format(beginningDayOfMonth)} - ${DateFormat.yMMMMd().format(endingDayOfMonth)}",
                textAlign: TextAlign.center,
              )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      setState(() {
                        var today = DateTime.now();
                        if (today.compareTo(endingDayOfMonth) <= 0 && today.compareTo(beginningDayOfMonth) > 0) return;
                        beginningDayOfMonth = DateTime(beginningDayOfMonth.year, beginningDayOfMonth.month + 1, 1);
                        endingDayOfMonth = DateTime(endingDayOfMonth.year, endingDayOfMonth.month + 2, 1)
                            .subtract(Duration(microseconds: 1));
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
                      var current = DateTime(endingDayOfMonth.year, endingDayOfMonth.month, value.toInt());
                      switch (value.toInt()) {
                        case 1:
                        case 6:
                        case 11:
                        case 16:
                        case 21:
                        case 26:
                          return DateFormat.MMMd().format(current);
                        case 31:
                          return DateFormat.MMMd().format(endingDayOfMonth);

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
                barGroups: StatisticCalculator.statisticByMonth(widget.history, beginningDayOfMonth, endingDayOfMonth),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
