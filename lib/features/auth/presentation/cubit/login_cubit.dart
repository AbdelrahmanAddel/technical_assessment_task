import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_use_case.dart';
import 'login_state.dart';

final class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(const LoginInitial());

  final LoginUseCase loginUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());

    final result = await loginUseCase(email: email, password: password);

    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (session) => emit(LoginSuccess(session)),
    );
  }
}
