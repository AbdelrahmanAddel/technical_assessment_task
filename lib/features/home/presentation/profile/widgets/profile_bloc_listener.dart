import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_state.dart';
import 'package:go_router/go_router.dart';

class ProfileBlocListener extends StatelessWidget {
  const ProfileBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => switch (current) {
        ProfileLogoutSuccess() || ProfileLogoutFailure() => true,
        _ => false,
      },
      listener: (context, state) {
        switch (state) {
          case ProfileLogoutSuccess():
            context.go(RoutesStrings.login);
          case ProfileLogoutFailure(:final user, :final message):
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
            context.read<ProfileCubit>().restoreProfile(user);
          case ProfileInitial():
          case ProfileLoading():
          case ProfileLoaded():
          case ProfileFailure():
            break;
        }
      },
      child: child,
    );
  }
}
