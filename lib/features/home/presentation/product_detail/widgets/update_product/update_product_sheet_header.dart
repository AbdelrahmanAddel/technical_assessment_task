import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class UpdateProductSheetHeader extends StatelessWidget {
  const UpdateProductSheetHeader({super.key, required this.title});

  final String title;

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
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpace(HomeDimension.detailSectionSpacing),
      ],
    );
  }
}
