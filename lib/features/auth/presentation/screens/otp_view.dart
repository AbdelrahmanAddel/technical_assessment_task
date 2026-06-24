import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/auth/presentation/auth_dimen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/otp_state.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/otp_bloc_listener.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.email});

  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  List<TextEditingController?> _controllers = [];

  String _readOtp() {
    return _controllers.map((controller) => controller?.text ?? '').join();
  }

  void _submit() {
    final otp = _readOtp();

    if (otp.length != AuthDimension.otpLength) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text(AppStrings.otpTooShort)));
      return;
    }

    context.read<OtpCubit>().verifyEmail(email: widget.email, otp: otp);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        final isLoading = state is OtpLoading;

        return AuthScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const OtpBlocListener(),
              const AuthHeader(
                title: AppStrings.verifyOtp,
                subtitle: AppStrings.enterOtpSentToEmail,
              ),
              verticalSpace(AuthDimension.emailTopSpacing),
              Text(
                widget.email,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(AuthDimension.otpTopSpacing),
              LayoutBuilder(
                builder: (context, constraints) {
                  return OtpTextField(
                    numberOfFields: AuthDimension.otpLength,
                    showFieldAsBox: true,
                    enabled: !isLoading,
                    borderWidth: AuthDimension.otpFieldBorderWidth,
                    borderColor: colors.border,
                    focusedBorderColor: colors.primary,
                    enabledBorderColor: colors.border,
                    disabledBorderColor: colors.border.withValues(alpha: 0.5),
                    fieldWidth: AuthDimension.otpFieldWidth(constraints.maxWidth),
                    fieldHeight: AuthDimension.otpFieldHeight,
                    borderRadius: AuthDimension.otpFieldBorderRadius,
                    margin: AuthDimension.otpFieldMargin,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    handleControllers: (controllers) => _controllers = controllers,
                    onSubmit: (_) => _submit(),
                  );
                },
              ),
              verticalSpace(AuthDimension.verifyButtonTopSpacing),
              AppButton(
                text: AppStrings.verify,
                isLoading: isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        );
      },
    );
  }
}
