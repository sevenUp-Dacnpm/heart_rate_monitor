import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';

class StatisticCalculator {
  static List<BarChartGroupData> statisticByWeek(List<HeartRate> heartRates, DateTime weekStart, DateTime weekend) {
    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent]),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
    ];
    var lengths = [0, 0, 0, 0, 0, 0, 0];

    for (var heartRate in heartRates) {
      if (heartRate.date.compareTo(weekStart) >= 0 && heartRate.date.compareTo(weekend) < 0) {
        int index = heartRate.date.weekday - 1;
        double sum = data[index].barRods.first.y * lengths[index] + heartRate.heartRate;
        lengths[index]++;
        data[index].barRods.first =
            BarChartRodData(y: sum / lengths[index], colors: [Colors.lightBlueAccent, Colors.greenAccent]);
      }
    }
    return data;
  }

  static List<BarChartGroupData> statisticByDay(List<HeartRate> heartRates, DateTime date) {
    List<BarChartGroupData> data = [];

    for (int i = 0; i <= 24; i++) {
      data.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent]),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    var lengths = List.filled(24, 0);
    for (var heartRate in heartRates) {
      if (heartRate.date.day == date.day && heartRate.date.month == date.month && heartRate.date.year == date.year) {
        int index = heartRate.date.hour;
        double sum = data[index].barRods.first.y * lengths[index] + heartRate.heartRate;
        lengths[index]++;
        data[index].barRods.first =
            BarChartRodData(y: sum / lengths[index], colors: [Colors.lightBlueAccent, Colors.greenAccent]);
      }
    }
    return data;
  }

  static List<BarChartGroupData> statisticByMonth(
      List<HeartRate> heartRates, DateTime beginningDate, DateTime endingDate) {
    List<BarChartGroupData> data = [];

    for (int i = 0; i <= 32; i++) {
      data.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(y: 0, colors: [Colors.lightBlueAccent, Colors.greenAccent]),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    var lengths = List.filled(32, 0);
    for (var heartRate in heartRates) {
      if (heartRate.date.month == beginningDate.month && heartRate.date.year == beginningDate.year) {
        int index = heartRate.date.day;
        double sum = data[index].barRods.first.y * lengths[index] + heartRate.heartRate;
        lengths[index]++;
        data[index].barRods.first =
            BarChartRodData(y: sum / lengths[index], colors: [Colors.lightBlueAccent, Colors.greenAccent]);
      }
    }
    return data;
  }
}
