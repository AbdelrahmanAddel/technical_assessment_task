import 'package:flutter/material.dart';

import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/theme_bottom_sheet.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/theme_mode_label.dart';

class ProfileThemeTile extends StatelessWidget {
  const ProfileThemeTile({super.key, required this.selectedMode});

  final ThemeMode selectedMode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(ProfileDimension.infoCardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => ThemeBottomSheet.show(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(
              ProfileDimension.infoCardRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(ProfileDimension.infoCardPadding),
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
                      Icons.palette_outlined,
                      size: ProfileDimension.infoIconSize,
                      color: colors.primary,
                    ),
                  ),
                ),
                horizontalSpace(ProfileDimension.infoRowSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.appearance,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.text.withValues(
                            alpha: ProfileDimension.subtitleAlpha,
                          ),
                        ),
                      ),
                      verticalSpace(2),
                      Text(
                        themeModeLabel(selectedMode),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.text.withValues(
                    alpha: ProfileDimension.subtitleAlpha,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
