import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/history_tab/history_tab.dart';

import 'package:heart_rate_monitor/screens/main_screen/home_tab/home_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/setting_tab/setting_tab.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_tab.dart';
import 'package:heart_rate_monitor/screens/main_screen/reminder_tab/reminder_list.dart';
import 'package:flutter/material.dart';

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
    // ReminderTab(),
    ReminderList(),
    SettingTab(),
  ];

  List<String> tabTitles = ["Statistic", "History", "Measure", "Reminder", "Setting"];

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
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onNavigatorTab,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(AppIcons.statistic),
              label: "Statistic",
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
                icon: Icon(AppIcons.heart),
                label: "Measure",
                activeIcon: Icon(
                  AppIcons.heart,
                  color: Color(0xFFF13741),
                )),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.reminder),
              label: "Reminder",
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.setting),
              label: "Setting",
            ),
          ],
        ),
        body: tabs[_currentIndex],

        floatingActionButton: _currentIndex==3? FloatingActionButton.extended(
          icon: Icon(
              Icons.add,
              color: Color(0xFF5CC6BC),
          ),
          label: const Text(
              'Create',
              style: TextStyle(
                color: Color(0xFF5CC6BC),
              ),
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            print("pressed it");
          },
        ):Text(''),
    );
  }
}
