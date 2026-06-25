import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/theme/app_colors.dart';
import 'package:flutter_techincal_test/features/auth/domain/mappers/user_mapper.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';

class ProfileAvatarPlaceholder extends StatelessWidget {
  const ProfileAvatarPlaceholder({
    super.key,
    required this.colors,
    required this.name,
    this.isLoading = false,
  });

  final AppColors colors;
  final String name;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ColoredBox(
        color: colors.primary.withValues(
          alpha: ProfileDimension.headerGradientAlpha,
        ),
        child: Center(
          child: SizedBox.square(
            dimension: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.primary,
            ),
          ),
        ),
      );
    }

    final initial = UserMapper.toAvatarInitial(name);

    return ColoredBox(
      color: colors.primary.withValues(
        alpha: ProfileDimension.headerGradientAlpha,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
