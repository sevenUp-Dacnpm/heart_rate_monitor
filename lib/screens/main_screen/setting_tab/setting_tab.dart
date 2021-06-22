import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/services/api_services/authentication_services/authentication_services.dart';
import 'package:heart_rate_monitor/widgets/icons/app_icons/app_icons.dart';
import 'package:heart_rate_monitor/widgets/icons/confirm_dialog/confirm_dialog.dart';

class SettingTab extends StatefulWidget {
  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool _isLoggedIn = AccessData().token != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            if (_isLoggedIn)
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/account").then((value) {
                    if (value != null) {
                      setState(() {
                        _isLoggedIn = value;
                      });
                    }
                  });
                },
                leading: Icon(AppIcons.edit),
                title: Text("Account"),
              ),
            if (_isLoggedIn)
              ListTile(
                leading: Icon(AppIcons.sync_icon),
                title: Text("Sync"),
              ),
            if (_isLoggedIn)
              ListTile(
                leading: Icon(AppIcons.clock),
                title: Text("MeasurementTime"),
              ),
            if (_isLoggedIn)
              ListTile(
                onTap: () {
                  showDialog(
                          context: context,
                          builder: (context) =>
                              ConfirmDialog("Do you want to logout?"))
                      .then((value) {
                    if (value == true) {
                      AccessData().token = null;
                      AccessData().user = null;
                      AuthenticationServices.removeAccessData();
                      setState(() {
                        _isLoggedIn = false;
                      });
                    }
                  });
                },
                leading: Icon(
                  AppIcons.logout,
                  color: Theme.of(context).errorColor,
                ),
                title: Text("Logout"),
              ),
            if (!_isLoggedIn)
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/login").then((value) {
                    if (value != null) {
                      setState(() {
                        _isLoggedIn = value;
                      });
                    }
                  });
                },
                leading: Icon(
                  AppIcons.login,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Login"),
              ),
          ],
        ),
      ),
    );
  }
}
