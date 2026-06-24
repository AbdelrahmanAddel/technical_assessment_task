import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/auth/presentation/auth_dimen.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AuthDimension.scaffoldOuterHorizontalPadding,
              vertical: AuthDimension.scaffoldOuterVerticalPadding,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: AuthDimension.scaffoldMaxWidth),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border.all(color: colors.border),
                  borderRadius: AuthDimension.scaffoldBorderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: colors.text.withValues(alpha: 0.06),
                      blurRadius: AuthDimension.scaffoldShadowBlur,
                      offset: Offset(0, AuthDimension.scaffoldShadowOffsetY),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(AuthDimension.scaffoldInnerPadding),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
