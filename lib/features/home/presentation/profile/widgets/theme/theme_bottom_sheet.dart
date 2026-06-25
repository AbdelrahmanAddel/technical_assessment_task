import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/theme_sheet_header.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/theme_sheet_options.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: themeCubit,
        child: const ThemeBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(HomeDimension.detailSheetRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ProfileDimension.horizontalPadding,
          HomeDimension.detailSheetTopPadding,
          ProfileDimension.horizontalPadding,
          HomeDimension.detailSheetBottomPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ThemeSheetHeader(),
            verticalSpace(ProfileDimension.infoRowSpacing),
            const ThemeSheetOptions(),
          ],
        ),
      ),
    );
  }
}
