import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/common/widget/custom_text_form_field.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/core/helper/app_validation.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/login_state.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_footer_action.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
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
      builder: (context, state) {
        final isLoading = switch (state) {
          LoginLoading() => true,
          LoginInitial() || LoginSuccess() || LoginFailure() => false,
        };

        return AuthScaffold(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AuthHeader(
                  title: AppStrings.welcomeBack,
                  subtitle: AppStrings.signInWithYourEmailAndPassword,
                ),
                verticalSpace(28.h),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: AppStrings.email,
                  hintText: AppStrings.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.mail_outline),
                  enabled: !isLoading,
                  validator: (value) =>
                      AppValidation.validate(ValidationType.email, value),
                ),
                verticalSpace(16.h),
                AuthPasswordField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  enabled: !isLoading,
                  onFieldSubmitted: (_) => _submit(),
                ),
                verticalSpace(24.h),
                AppButton(
                  text: AppStrings.login,
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
                verticalSpace(14.h),
                AuthFooterAction(
                  message: AppStrings.noAccountMessage,
                  actionText: AppStrings.createOne,
                  onPressed: isLoading
                      ? null
                      : () => context.go(RoutesStrings.register),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
