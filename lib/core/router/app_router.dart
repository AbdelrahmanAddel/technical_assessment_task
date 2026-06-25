import 'package:go_router/go_router.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_techincal_test/features/auth/presentation/screens/splash_screen.dart';

import '../../features/home/domain/entities/product.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/product_detail/product_detail_screen.dart';
import 'app_page_transitions.dart';
import 'routes_strings.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutesStrings.splash,
    routes: [
      GoRoute(
        path: RoutesStrings.splash,
        pageBuilder: (context, state) => AppPageTransitions.fromState(
          state: state,
          child: const SplashScreen(),
          transition: AppPageTransition.none,
        ),
      ),
      GoRoute(
        path: RoutesStrings.login,
        pageBuilder: (context, state) => AppPageTransitions.fromState(
          state: state,
          child: const LoginScreen(),
          transition: AppPageTransition.fade,
        ),
      ),
      GoRoute(
        path: RoutesStrings.register,
        pageBuilder: (context, state) => AppPageTransitions.fromState(
          state: state,
          child: const RegisterScreen(),
          transition: AppPageTransition.slideFromRight,
        ),
      ),
      GoRoute(
        path: RoutesStrings.otp,
        pageBuilder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return AppPageTransitions.fromState(
            state: state,
            child: OtpScreen(email: email),
            transition: AppPageTransition.slideFromRight,
          );
        },
      ),
      GoRoute(
        path: RoutesStrings.home,
        pageBuilder: (context, state) => AppPageTransitions.fromState(
          state: state,
          child: const HomeScreen(),
          transition: AppPageTransition.fade,
        ),
      ),
      GoRoute(
        path: '${RoutesStrings.productDetails}/:productId',
        pageBuilder: (context, state) {
          final productId = state.pathParameters['productId']!;
          final preview = state.extra;
          return AppPageTransitions.fromState(
            state: state,
            child: ProductDetailScreen(
              productId: productId,
              previewProduct: preview is Product ? preview : null,
            ),
            transition: AppPageTransition.slideFromRight,
          );
        },
      ),
    ],
  );
}
