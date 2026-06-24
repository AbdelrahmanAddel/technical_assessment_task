import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/otp_state.dart';
import 'package:go_router/go_router.dart';

class OtpBlocListener extends StatelessWidget {
  const OtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listenWhen: (previous, current) => switch (current) {
        OtpFailure() || OtpSuccess() => true,
        _ => false,
      },
      listener: (context, state) {
        switch (state) {
          case OtpSuccess():
            context.go(RoutesStrings.login);
          case OtpFailure(:final message):
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          case OtpInitial():
          case OtpLoading():
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
