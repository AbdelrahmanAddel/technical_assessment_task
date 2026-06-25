import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class DeleteProductDialog {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colors = dialogContext.colors;

        return AlertDialog(
          backgroundColor: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              HomeDimension.productCardBorderRadius,
            ),
          ),
          title: Text(
            AppStrings.deleteProductTitle,
            style: TextStyle(color: colors.text),
          ),
          content: Text(
            AppStrings.deleteProductMessage,
            style: TextStyle(color: colors.text.withValues(alpha: 0.75)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(foregroundColor: colors.error),
              child: const Text(AppStrings.delete),
            ),
          ],
        );
      },
    );
  }
}
