import 'package:heart_rate_monitor/models/user/user.dart';

class AccessData {
  User user;
  String token;

  void fromJson(Map<String, dynamic> json) {
    this.user = User.fromJson(json["user"]);

    this.token = json["token"];
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
  static final AccessData _singleton = AccessData._create();

  factory AccessData() {
    return _singleton;
  }

  AccessData._create();
}
