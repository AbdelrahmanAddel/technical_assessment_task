import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/check_auth_use_case.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final hasToken = await getIt<CheckAuthUseCase>().call();
    if (!mounted) return;

    context.go(hasToken ? RoutesStrings.home : RoutesStrings.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Center(
        child: Text(
          'Hello',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: context.colors.primary,
          ),
        ),
      ),
    );
  }
}
