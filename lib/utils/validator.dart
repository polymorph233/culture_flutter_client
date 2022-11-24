import 'package:email_validator/email_validator.dart';

class Validator {
  static bool isValidEmail(String? email) {
    return EmailValidator.validate(email ?? "");
  }

  static bool isValidPassword(String? password) {
    return (password?.length ?? 0) > 6 &&
        RegExp(r"[a-zA-Z0-9-_\?\*#\(\)]+")
            .hasMatch(password ?? "");
  }
}