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
    final password = value ?? '';

    if (password.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }
}
