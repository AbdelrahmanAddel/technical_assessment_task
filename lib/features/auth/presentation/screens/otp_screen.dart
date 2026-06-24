import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/otp_view.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OtpCubit>(),
      child: OtpView(email: email),
    );
  }
}
