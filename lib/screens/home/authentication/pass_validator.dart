class PasswordValidator {
  PasswordValidator(String newPassword);

  static bool hasMinLength(String password) => password.length > 8;
  static bool hasUppercase(String password) => password.contains(RegExp(r'[A-Z]'));
  static bool hasNumber(String password) => password.contains(RegExp(r'[0-9]'));
  static bool hasSpecialCharacter(String password) => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  static Map<String, bool> validate(String password) {
    return {
      'Have more than 8 characters': hasMinLength(password),
      'Contains a capital letter': hasUppercase(password),
      'Contains a number': hasNumber(password),
      'Contains a special character': hasSpecialCharacter(password),
    };
  }
}
class EmailValidator {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  static Map<String, bool> validate(String email) {
    return {
      'Valid email format': isValidEmail(email),
    };
  }
}
