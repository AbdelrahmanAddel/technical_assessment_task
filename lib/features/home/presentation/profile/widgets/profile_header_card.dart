import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_avatar.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(ProfileDimension.headerCardRadius),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(
              alpha: ProfileDimension.headerGradientAlpha,
            ),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ProfileDimension.headerCardPadding),
        child: Column(
          children: [
            ProfileAvatar(
              imageUrl: user.profilePicture,
              name: user.fullName,
            ),
            verticalSpace(ProfileDimension.nameTopSpacing),
            Text(
              user.fullName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.text,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(ProfileDimension.emailTopSpacing),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.text.withValues(
                  alpha: ProfileDimension.subtitleAlpha,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
