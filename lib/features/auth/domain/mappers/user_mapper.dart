abstract final class UserMapper {
  static String toAvatarInitial(String fullName) {
    final trimmed = fullName.trim();
    return trimmed.isNotEmpty ? trimmed[0].toUpperCase() : '?';
  }
}
