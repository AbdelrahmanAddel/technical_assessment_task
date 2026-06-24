import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/features/auth/data/models/register_request.dart';

import '../../domain/usecases/register_use_case.dart';
import 'register_state.dart';

final class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUseCase})
    : super(const RegisterInitial());

  final RegisterUseCase registerUseCase;

  Future<void> register({required RegisterRequestParameters request}) async {
    if (state is RegisterLoading) return;
    emit(const RegisterLoading());

    final result = await registerUseCase(request: request);

    if (isClosed) return;

    result.fold(
      (failure) => emit(RegisterFailure(failure.errMessage)),
      (_) => emit(RegisterSuccess(request.email)),
    );
  }
}
