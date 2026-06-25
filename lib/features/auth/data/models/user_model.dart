import '../../../../core/constant/api_strings.dart';

final class UserModel {
  const UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.profilePicture,
  });

  final String userId;
  final String email;
  final String fullName;
  final String profilePicture;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json[ApiKeys.userId] as String,
      email: json[ApiKeys.email] as String,
      fullName: json[ApiKeys.fullName] as String,
      profilePicture: json[ApiKeys.profilePicture] as String? ?? '',
    );
  }
}
