import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/body_state.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/heart_rate.dart';
import 'package:heart_rate_monitor/services/api_services/api_services.dart';
import 'package:http/http.dart';

class HeartRateServices {
  static Future<bool> saveHeartRate(HeartRate heartRate) async {
    Uri url = Uri.https(APIServices.apiUrl, "/heart_rate_records");
    print("${AccessData().token}");
    var response = await post(url,
        headers: {
          HttpHeaders.authorizationHeader: "${AccessData().token}",
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode(heartRate.toJson()));
    print(response.body);
    if (APIServices.handle401Unauthorized(response)) {
      return false;
    }

    return response.statusCode == 201;
  }

  static Future<List<HeartRate>> getHeartRateHistory() async {
    Uri url = Uri.https(APIServices.apiUrl, "/heart_rate_records");
    var response = await get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "${AccessData().token}",
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
    );
    print(response.body);
    if (APIServices.handle401Unauthorized(response)) {
      return [];
    }
    return List<HeartRate>.from(jsonDecode(response.body).map((e) => HeartRate.fromJson(e)));
  }
}
