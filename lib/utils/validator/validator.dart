class Validator {
  static String validateUsername(String username) {
    return username.isEmpty ? "Username cannot be empty!" : null;
  }

  static String validatePassword(String password) {
    return password.length >= 6 ? null : "Password must be at least 6 characters!";
  }
}
