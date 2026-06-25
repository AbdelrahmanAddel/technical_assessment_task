import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.account,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(ProfileDimension.infoRowSpacing),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(ProfileDimension.infoCardRadius),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: EdgeInsets.all(ProfileDimension.infoCardPadding),
            child: Column(
              children: [
                _ProfileInfoRow(
                  icon: Icons.person_outline,
                  label: AppStrings.name,
                  value: user.fullName,
                ),
                Divider(height: ProfileDimension.infoRowSpacing * 2, color: colors.border),
                _ProfileInfoRow(
                  icon: Icons.email_outlined,
                  label: AppStrings.email,
                  value: user.email,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primary.withValues(
              alpha: ProfileDimension.headerGradientAlpha,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox.square(
            dimension: ProfileDimension.infoIconBoxSize,
            child: Icon(
              icon,
              size: ProfileDimension.infoIconSize,
              color: colors.primary,
            ),
          ),
        ),
        SizedBox(width: ProfileDimension.infoRowSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.text.withValues(
                    alpha: ProfileDimension.subtitleAlpha,
                  ),
                ),
              ),
              verticalSpace(2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
