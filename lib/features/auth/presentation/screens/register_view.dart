import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/common/widget/custom_text_form_field.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/app_validation.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/data/models/register_request.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/register_state.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_footer_action.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/register_bloc_listener.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<RegisterCubit>().register(
      request: RegisterRequestParameters(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return AuthScaffold(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const RegisterBlocListener(),
                const AuthHeader(
                  title: AppStrings.createAccount,
                  subtitle: AppStrings.enterYourDetailsToRegister,
                ),
                verticalSpace(28.h),
                CustomTextFormField(
                  controller: _firstNameController,
                  labelText: AppStrings.firstName,
                  hintText: AppStrings.enterYourFirstName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  enabled: !isLoading,
                  validator: (value) =>
                      AppValidation.validate(ValidationType.name, value),
                ),
                verticalSpace(16.h),
                CustomTextFormField(
                  controller: _lastNameController,
                  labelText: AppStrings.lastName,
                  hintText: AppStrings.enterYourLastName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  enabled: !isLoading,
                  validator: (value) =>
                      AppValidation.validate(ValidationType.name, value),
                ),
                verticalSpace(16.h),
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
                  text: AppStrings.register,
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
                verticalSpace(14.h),
                AuthFooterAction(
                  message: AppStrings.alreadyHaveAnAccountMessage,
                  actionText: AppStrings.login,
                  onPressed: isLoading
                      ? null
                      : () => context.go(RoutesStrings.login),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
