import 'package:go_router/go_router.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/splash_screen.dart';

import '../../features/home/presentation/home_screen.dart';
import 'routes_strings.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutesStrings.splash,
    routes: [
      GoRoute(
        path: RoutesStrings.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutesStrings.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutesStrings.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutesStrings.otp,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: RoutesStrings.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
