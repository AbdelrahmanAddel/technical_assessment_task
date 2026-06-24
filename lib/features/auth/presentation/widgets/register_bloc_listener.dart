import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/register_state.dart';
import 'package:go_router/go_router.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => switch (current) {
        RegisterFailure() || RegisterSuccess() => true,
        _ => false,
      },
      listener: (context, state) {
        switch (state) {
          case RegisterSuccess(:final email):
            context.go(
              '${RoutesStrings.otp}?email=$email',
            );
          case RegisterFailure(:final message):
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          case RegisterInitial():
          case RegisterLoading():
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
