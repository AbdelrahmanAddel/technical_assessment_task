import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/common/widget/app_placeholder_card.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';

class ProfileErrorView extends StatelessWidget {
  const ProfileErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ProfileDimension.horizontalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPlaceholderCard(message: message),
            verticalSpace(ProfileDimension.sectionTopSpacing),
            AppButton(
              text: AppStrings.retry,
              onPressed: () => context.read<ProfileCubit>().refreshProfile(),
            ),
          ],
        ),
      ),
    );
  }
}
