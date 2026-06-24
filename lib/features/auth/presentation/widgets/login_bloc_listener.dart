import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/login_state.dart';
import 'package:go_router/go_router.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => switch (current) {
        LoginFailure() || LoginSuccess() => true,
        _ => false,
      },
      listener: (context, state) {
        switch (state) {
          case LoginSuccess():
            context.go(RoutesStrings.home);
          case LoginFailure(:final message):
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          case LoginInitial():
          case LoginLoading():
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
