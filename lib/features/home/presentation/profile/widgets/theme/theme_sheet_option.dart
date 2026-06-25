import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';

class ThemeSheetOption extends StatelessWidget {
  const ThemeSheetOption({
    super.key,
    required this.mode,
    required this.selectedMode,
    required this.icon,
    required this.label,
  });

  final ThemeMode mode;
  final ThemeMode selectedMode;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isSelected = mode == selectedMode;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<ThemeCubit>().setThemeMode(mode);
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(ProfileDimension.infoCardRadius),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ProfileDimension.infoCardPadding,
            vertical: ProfileDimension.infoRowSpacing,
          ),
          child: Row(
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
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colors.primary,
                  size: ProfileDimension.infoIconSize,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
