import 'package:coinly/utils/app_strings.dart';

class AppUtils {
  /// Password validation logic
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordCannotBeEmpty;
    }
    if (value.length < 8) {
      return AppStrings.passwordMustBeLong;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppStrings.passwordContainUppercaseLetter;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppStrings.passwordContainLowercaseLetter;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return AppStrings.passwordContainNumber;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return AppStrings.passwordContainSpecialCharacter;
    }
    return null;
  }

  /// Email validation logic
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailCannotBeEmpty;
    }
    if (!RegExp(AppStrings.emailPattern).hasMatch(value)) {
      return AppStrings.enterValidEmailAddress;
    }
    return null;
  }
}
