import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/profile_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/profile/widgets/profile_bloc_listener.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const ProfileBlocListener(
        child: ProfileView(),
      ),
    );
  }
}
