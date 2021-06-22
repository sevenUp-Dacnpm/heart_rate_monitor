import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/screens/authentication/login_screen/login_screen.dart';
import 'package:heart_rate_monitor/screens/authentication/register_screen/register_screen.dart';
import 'package:heart_rate_monitor/screens/keys/keys.dart';
import 'package:heart_rate_monitor/screens/main_screen/account/account.dart';
import 'package:heart_rate_monitor/screens/main_screen/main_screen.dart';
import 'package:heart_rate_monitor/services/api_services/authentication_services/authentication_services.dart';
import 'package:heart_rate_monitor/services/sqlite_services/sqlite_services.dart';

import 'screens/main_screen/reminder_tab/reminder_detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteServices.initSqlite();
  var data = await AuthenticationServices.getAccessData();
  AccessData().token = data.token;
  AccessData().user = data.user;
  runApp(HeartRateMonitor());
}

class HeartRateMonitor extends StatefulWidget {
  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Heart Rate Monitor',
      navigatorKey: Keys.navigationKeys,
      theme: ThemeData(
        primaryColor: Color(0xFF2CC6AE),
        fontFamily: "Laila",
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Color(0xFF2CC6AE)),
        ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xFF2CC6AE),
            ),
        accentColor: Color(0xFF2CC6AE),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF2CC6AE),
            unselectedItemColor: Colors.black87,
            showUnselectedLabels: true),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        errorColor: Color(0xFFEE393D),
        textTheme: TextTheme(
          headline3: TextStyle(color: Color(0xFFEE393D), fontSize: 24),
          headline4: TextStyle(color: Colors.black87, fontSize: 18),
          bodyText2: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Color(0xFF2CC6AE),
          selectionHandleColor: Color(0xFF2CC6AE),
          cursorColor: Color(0xFF2CC6AE),
        ),
        dividerColor: Color(0xFF2CC6AE),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2CC6AE)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))))),
      ),
      routes: {
        "/": (context) => MainScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/reminder_detail": (context) => ReminderDetail(),
        "/account": (context) => Account()
      },
    );
  }
}
