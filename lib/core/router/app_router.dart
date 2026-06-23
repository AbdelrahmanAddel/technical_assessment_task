import 'package:go_router/go_router.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/register_screen.dart';

import '../../features/home/presentation/home_screen.dart';
import 'routes_strings.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutesStrings.login,
    routes: [
      GoRoute(
        path: RoutesStrings.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutesStrings.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutesStrings.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
