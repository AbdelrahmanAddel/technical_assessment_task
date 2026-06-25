import 'package:flutter/material.dart';

import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';

class ThemeSheetHeader extends StatelessWidget {
  const ThemeSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: HomeDimension.detailSheetHandleWidth,
            height: HomeDimension.detailSheetHandleHeight,
            decoration: BoxDecoration(
              color: colors.border,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        verticalSpace(HomeDimension.detailSectionSpacing),
        Text(
          AppStrings.appearance,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpace(4),
        Text(
          AppStrings.appearanceSubtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.text.withValues(
              alpha: ProfileDimension.subtitleAlpha,
            ),
          ),
        ),
      ],
    );
  }
}
