import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/user/user.dart';
import 'package:http/http.dart';

import '../api_services.dart';

class AccountServices {
  static Future<bool> updateAccount(User user) async {
    Uri url = Uri.https(APIServices.apiUrl, "users/profile");
    print("${AccessData().token}");
    var response = await put(url,
        headers: {
          HttpHeaders.authorizationHeader: "${AccessData().token}",
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode(user.toJson()));
    print(response.body);
    if (APIServices.handle401Unauthorized(response)) {
      return false;
    }
    return response.statusCode == 201;
  }
}
