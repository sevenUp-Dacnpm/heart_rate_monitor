import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/user/user.dart';
import 'package:http/http.dart';

import '../api_services.dart';

class AccountServices {
  static Future<Profile> updateAccount(User user) async {
    Uri url = Uri.https(APIServices.apiUrl, "users/profile");
    print("${AccessData().token}");
    var response = await put(url,
        headers: {
          HttpHeaders.authorizationHeader: "${AccessData().token}",
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode(user.profile.toJson()));
    print(response.body);
    if (APIServices.handle401Unauthorized(response)) {
      return null;
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Profile.fromJson(json["profile"]);
    } else {
      return null;
    }
  }
}
