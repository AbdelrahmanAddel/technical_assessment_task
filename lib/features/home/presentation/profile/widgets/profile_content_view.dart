import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_header_card.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_info_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_logout_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/theme/profile_theme_section.dart';

class ProfileContentView extends StatelessWidget {
  const ProfileContentView({
    super.key,
    required this.user,
    required this.isLoggingOut,
    this.isRefreshing = false,
  });

  final User user;
  final bool isLoggingOut;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ColoredBox(
      color: colors.background,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<ProfileCubit>().refreshProfile(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: ProfileDimension.horizontalPadding,
              vertical: ProfileDimension.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isRefreshing) const LinearProgressIndicator(),
                ProfileHeaderCard(user: user),
                verticalSpace(ProfileDimension.sectionTopSpacing),
                ProfileInfoSection(user: user),
                verticalSpace(ProfileDimension.sectionTopSpacing),
                const ProfileThemeSection(),
                verticalSpace(ProfileDimension.logoutTopSpacing),
                ProfileLogoutSection(isLoggingOut: isLoggingOut),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
