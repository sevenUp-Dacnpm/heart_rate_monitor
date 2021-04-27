import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heart_rate_monitor/screens/main_screen/main_screen.dart';

void main() {
  runApp(HeartRateMonitor());
}

class HeartRateMonitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Heart Rate Monitor',
      theme: ThemeData(
        primaryColor: Color(0xFF2CC6AE),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF2CC6AE),
            unselectedItemColor: Colors.black87,
            showUnselectedLabels: true),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        textTheme: TextTheme(
          headline3: TextStyle(color: Color(0xFFEE393D), fontSize: 24),
        ),
        dividerColor: Color(0xFF2CC6AE),
      ),
      routes: {"/": (context) => MainScreen()},
    );
  }
}
