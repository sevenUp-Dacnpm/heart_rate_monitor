import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/user/user.dart';
import 'package:heart_rate_monitor/services/api_services/api_services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  static Future<AccessData> login(String username, String password) async {
    Uri url = Uri.https(APIServices.apiUrl, "/login");
    var response = await post(url,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      var data = AccessData.fromJson(jsonDecode(response.body));
      saveAccessData(data);
      return data;
    }
    return null;
  }

  static Future<User> register(String username, String password) async {
    Uri url = Uri.https(APIServices.apiUrl, "/register");
    var response = await post(url,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<bool> verifyToken(String token) async {
    Uri url = Uri.https(APIServices.apiUrl, "/verify_token");
    var response = await post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response.body);
    return response.statusCode == 200;
  }

  static Future<void> saveAccessData(AccessData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", data.token);
    prefs.setString("fullName", data.user.profile.fullName);
    prefs.setString("gender", data.user.profile.gender);
    prefs.setString("dob", data.user.profile.dob?.toIso8601String());
    prefs.setDouble("weight", data.user.profile.weight);
    prefs.setDouble("height", data.user.profile.height);
  }

  static Future<void> removeAccessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("fullName");
    prefs.remove("gender");
    prefs.remove("dob");
    prefs.remove("weight");
    prefs.remove("height");
  }

  static Future<AccessData> getAccessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    var fullName = prefs.get("fullName");
    var gender = prefs.get("gender");
    var dob = prefs.get("dob");
    var weight = prefs.get("weight");
    var height = prefs.get("height");
    return AccessData.withData(
        token: token,
        user: User(
            profile: Profile(
          dob: dob == null ? null : DateTime.parse(dob),
          fullName: fullName,
          gender: gender,
          weight: weight,
          height: height,
        )));
  }
}
