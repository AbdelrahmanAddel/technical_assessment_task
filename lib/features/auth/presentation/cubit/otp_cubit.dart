import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/verify_email_use_case.dart';
import 'otp_state.dart';

final class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.verifyEmailUseCase}) : super(const OtpInitial());

  final VerifyEmailUseCase verifyEmailUseCase;

  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    if (state is OtpLoading) return;
    emit(const OtpLoading());

    final result = await verifyEmailUseCase(email: email, otp: otp);

    if (isClosed) return;

    result.fold(
      (failure) => emit(OtpFailure(failure.errMessage)),
      (_) => emit(const OtpSuccess()),
    );
  }
}
