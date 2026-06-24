import '../../../../core/constant/api_strings.dart';

final class RegisterRequestParameters {
  const RegisterRequestParameters({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.email: email,
      ApiKeys.password: password,
      ApiKeys.firstName: firstName,
      ApiKeys.lastName: lastName,
    };
  }
}
