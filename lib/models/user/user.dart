class User {
  User({
    this.profile,
    this.id,
    this.username,
    this.password,
    this.v,
  });

  Profile profile;
  String id;
  String username;
  String password;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        profile: Profile.fromJson(json["profile"]),
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "_id": id,
        "username": username,
        "password": password,
        "__v": v,
      };
}

class Profile {
  Profile({
    this.dob,
    this.fullName,
    this.gender,
    this.weight,
    this.height,
  });

  DateTime dob;
  String fullName;
  String gender;
  double weight;
  double height;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        dob: DateTime.parse(json["dob"]),
        fullName: json["fullName"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "dob": dob?.toIso8601String(),
        "fullName": fullName,
        "gender": gender,
        "weight": weight,
        "height": height,
      };
}
