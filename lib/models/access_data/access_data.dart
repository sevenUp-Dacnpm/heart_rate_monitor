import 'package:heart_rate_monitor/models/user/user.dart';

class AccessData {
  AccessData.withData({this.user, this.token});

  User user;
  String token;

  factory AccessData.fromJson(Map<String, dynamic> json) => AccessData.withData(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

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
