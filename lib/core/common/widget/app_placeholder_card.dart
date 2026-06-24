import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/common/app_dimen.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';

class AppPlaceholderCard extends StatelessWidget {
  const AppPlaceholderCard({
    super.key,
    required this.message,
    this.title,
  });

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: EdgeInsets.all(AppDimension.placeholderOuterPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(
            AppDimension.placeholderBorderRadius,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppDimension.placeholderInnerPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.text,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(AppDimension.placeholderTitleSpacing),
                ],
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.text.withValues(
                      alpha: AppDimension.placeholderSubtitleAlpha,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
