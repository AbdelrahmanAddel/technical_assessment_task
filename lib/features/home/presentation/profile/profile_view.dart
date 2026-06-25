import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_state.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_content_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_error_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/states/products_loading_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileInitial() || ProfileLoading() => const ProductsLoadingView(),
          ProfileFailure(:final message) => ProfileErrorView(message: message),
          ProfileLoaded(:final user, :final isLoggingOut) => ProfileContentView(
            user: user,
            isLoggingOut: isLoggingOut,
          ),
          ProfileLogoutFailure(:final user) => ProfileContentView(
            user: user,
            isLoggingOut: false,
          ),
          ProfileLogoutSuccess() => const ProductsLoadingView(),
        };
      },
    );
  }
}
