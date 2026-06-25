import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/theme_sheet_option.dart';

class ThemeSheetOptions extends StatelessWidget {
  const ThemeSheetOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, selectedMode) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(
              ProfileDimension.infoCardRadius,
            ),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              ThemeSheetOption(
                mode: ThemeMode.light,
                selectedMode: selectedMode,
                icon: Icons.light_mode_rounded,
                label: AppStrings.lightTheme,
              ),
              Divider(height: 1, color: colors.border),
              ThemeSheetOption(
                mode: ThemeMode.dark,
                selectedMode: selectedMode,
                icon: Icons.dark_mode_rounded,
                label: AppStrings.darkTheme,
              ),
              Divider(height: 1, color: colors.border),
              ThemeSheetOption(
                mode: ThemeMode.system,
                selectedMode: selectedMode,
                icon: Icons.brightness_auto_rounded,
                label: AppStrings.systemTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}
