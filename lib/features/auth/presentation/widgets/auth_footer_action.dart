import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/theme/app_text_styles.dart';

class AuthFooterAction extends StatelessWidget {
  const AuthFooterAction({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
  });

  final String message;
  final String actionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            message,
            style: AppTextStyles.caption(
              color: colors.text.withValues(alpha: 0.66),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: AppTextStyles.caption(color: colors.primary),
          ),
        ),
      ],
    );
  }
}
