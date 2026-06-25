import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';

class ProfileLogoutSection extends StatelessWidget {
  const ProfileLogoutSection({
    super.key,
    required this.isLoggingOut,
  });

  final bool isLoggingOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppButton(
      text: AppStrings.logout,
      isLoading: isLoggingOut,
      backgroundColor: colors.error,
      icon: Icon(Icons.logout_rounded, size: 20, color: Colors.white),
      onPressed: () => context.read<ProfileCubit>().logout(),
    );
  }
}
