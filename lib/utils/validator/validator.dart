class Validator {
  static String validateUsername(String username) {
    return username.isEmpty ? "Username không được bỏ trống" : null;
  }

  static String validatePassword(String password) {
    return password.length >= 6 ? null : "Mật khẩu phải chứa ít nhất 6 ký tự!";
  }
}
