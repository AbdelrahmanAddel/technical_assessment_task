import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';

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
      padding: EdgeInsets.all(24.w),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
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
                  SizedBox(height: 8.h),
                ],
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.text.withValues(alpha: 0.72),
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
