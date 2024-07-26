// password_utils.dart
bool isValidPassword(String password) {
  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length >= 8;
  return hasUppercase && hasLowercase && hasSpecialCharacter && hasMinLength;
}
