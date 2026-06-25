import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/profile_theme_tile.dart';

class ProfileThemeSection extends StatelessWidget {
  const ProfileThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.appearance,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(ProfileDimension.infoRowSpacing),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, selectedMode) {
            return ProfileThemeTile(selectedMode: selectedMode);
          },
        ),
      ],
    );
  }
}
