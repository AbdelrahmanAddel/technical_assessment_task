import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_header_card.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_info_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_logout_section.dart';

class ProfileContentView extends StatelessWidget {
  const ProfileContentView({
    super.key,
    required this.user,
    required this.isLoggingOut,
  });

  final User user;
  final bool isLoggingOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ColoredBox(
      color: colors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ProfileDimension.horizontalPadding,
            vertical: ProfileDimension.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeaderCard(user: user),
              verticalSpace(ProfileDimension.sectionTopSpacing),
              ProfileInfoSection(user: user),
              verticalSpace(ProfileDimension.logoutTopSpacing),
              ProfileLogoutSection(isLoggingOut: isLoggingOut),
            ],
          ),
        ),
      ),
    );
  }
}
