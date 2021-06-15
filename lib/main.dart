import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heart_rate_monitor/screens/authentication/login_screen/login_screen.dart';
import 'package:heart_rate_monitor/screens/authentication/register_screen/register_screen.dart';
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
        fontFamily: "Laila",
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF2CC6AE),
            unselectedItemColor: Colors.black87,
            showUnselectedLabels: true),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        textTheme: TextTheme(
          headline3: TextStyle(color: Color(0xFFEE393D), fontSize: 24),
          headline4: TextStyle(color: Colors.black87, fontSize: 18),
          bodyText2: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        dividerColor: Color(0xFF2CC6AE),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2CC6AE)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))),
      ),
      routes: {
        "/": (context) => LoginScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
      },
    );
  }
}
