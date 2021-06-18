import 'package:heart_rate_monitor/screens/keys/keys.dart';
import 'package:http/http.dart';

class APIServices {
  static String apiUrl = "heart-rate-monitor-api.herokuapp.com";

  static bool handle401Unauthorized(Response response) {
    if (response.statusCode == 401) {
      Keys.navigationKeys.currentState.pushNamed("/login");
      return true;
    }
    return false;
  }
}
