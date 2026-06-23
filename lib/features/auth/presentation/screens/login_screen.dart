import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/common/widget/custom_text_form_field.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/app_validation.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_footer_action.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:flutter_techincal_test/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
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
              validator: (value) =>
                  AppValidation.validate(ValidationType.email, value),
            ),
            verticalSpace(16.h),
            AuthPasswordField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            verticalSpace(24.h),
            AppButton(text: AppStrings.login, onPressed: _submit),
            verticalSpace(14.h),
            AuthFooterAction(
              message: AppStrings.noAccountMessage,
              actionText: AppStrings.createOne,
              onPressed: () => context.go(RoutesStrings.register),
            ),
          ],
        ),
      ),
    );
  }
}
