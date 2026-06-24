sealed class OtpState {
  const OtpState();
}

final class OtpInitial extends OtpState {
  const OtpInitial();
}

final class OtpLoading extends OtpState {
  const OtpLoading();
}

final class OtpSuccess extends OtpState {
  const OtpSuccess();
}

final class OtpFailure extends OtpState {
  const OtpFailure(this.message);

  final String message;
}
