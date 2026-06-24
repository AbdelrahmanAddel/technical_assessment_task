import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/register_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: const RegisterView(),
    );
  }
}
