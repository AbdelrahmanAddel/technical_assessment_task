import 'package:flutter_techincal_test/core/constant/app_strings.dart';

enum ValidationType { name, email, password }

abstract final class AppValidation {
  static String? validate(ValidationType type, String? value) {
    switch (type) {
      case ValidationType.name:
        return _validateName(value);
      case ValidationType.email:
        return _validateEmail(value);
      case ValidationType.password:
        return _validatePassword(value);
    }
  }

  static String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return AppStrings.nameRequired;
    }
    if (name.length < 2) {
      return AppStrings.nameTooShort;
    }
    return null;
  }

  static String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return AppStrings.emailRequired;
    }

    final isValidEmail = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    if (!isValidEmail) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  static String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';

    if (password.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (password.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }
}
