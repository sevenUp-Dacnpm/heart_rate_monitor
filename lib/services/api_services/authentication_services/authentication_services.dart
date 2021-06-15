import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/services/api_services/api_services.dart';
import 'package:http/http.dart';

class AuthenticationServices {
  static Future<bool> login(String username, String password) async {
    Uri url = Uri.https(APIServices.apiUrl, "/login");
    var response = await post(url,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      AccessData().fromJson(jsonDecode(response.body));
      return true;
    }
    return false;
  }
}
