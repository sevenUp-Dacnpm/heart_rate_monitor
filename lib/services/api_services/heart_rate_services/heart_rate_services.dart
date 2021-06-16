import 'dart:convert';
import 'dart:io';

import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/heart_rate_model/body_state.dart';
import 'package:heart_rate_monitor/services/api_services/api_services.dart';
import 'package:http/http.dart';

class HeartRateServices {
  static Future<bool> saveHeartRate(int bpm, BodyState bodyState) async {
    Uri url = Uri.https(APIServices.apiUrl, "/heart_rate_records");
    print("${AccessData().token}");
    var response = await post(url,
        headers: {
          HttpHeaders.authorizationHeader: "${AccessData().token}",
        },
        body: jsonEncode({
          "heartRate": bpm,
          "state": bodyState.toString(),
        }));
    print(response.body);
    return response.statusCode == 200;
  }
}
