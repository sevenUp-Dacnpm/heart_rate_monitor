class Validator {
  static String validateUsername(String username) {
    return username.isEmpty ? "Username cannot be empty!" : null;
  }

  static String validatePassword(String password) {
    return password.length >= 6
        ? null
        : "Password must be at least 6 characters!";
  }

  static String validateWeight(String weight) {
    return double.tryParse(weight) != null
        ? null
        : "The weight must be a number";
  }

  static String validateHeight(String height) {
    return double.tryParse(height) != null
        ? null
        : "The weight must be a number";
  }
}
