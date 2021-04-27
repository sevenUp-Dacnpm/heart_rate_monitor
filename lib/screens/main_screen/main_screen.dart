import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/history_tab/history_tab.dart';

import 'package:heart_rate_monitor/screens/main_screen/home_tab/home_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/setting_tab/setting_tab.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  List<Widget> tabs = [
    SettingTab(),
    HistoryTab(),
    HomeTab(),
    SettingTab(),
    SettingTab(),
  ];

  void onNavigatorTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Measure",
          ),
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
