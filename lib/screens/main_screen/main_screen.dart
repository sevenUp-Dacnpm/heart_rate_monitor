import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/history_tab/history_tab.dart';

import 'package:heart_rate_monitor/screens/main_screen/home_tab/home_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/setting_tab/setting_tab.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  String _currentTabTitle = 'Measure';

  List<Widget> tabs = [
    SettingTab(),
    HistoryTab(),
    HomeTab(),
    ReminderTab(),
    SettingTab(),
  ];

  List<String> tabTitles = [
    "Statistic",
    "History",
    "Measure",
    "Reminder",
    "Setting"
  ];

  void onNavigatorTab(index) {
    setState(() {
      _currentIndex = index;
      _currentTabTitle = tabTitles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$_currentTabTitle'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onNavigatorTab,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_rounded),
              label: "Statistic",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
                icon: Icon(AppIcons.heart_beat),
                label: "Measure",
                activeIcon: Icon(
                  AppIcons.heart_beat,
                  color: Color(0xFFF13741),
                )),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.reminder),
              label: "Reminder",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
        ),
        body: tabs[_currentIndex]);
  }
}
