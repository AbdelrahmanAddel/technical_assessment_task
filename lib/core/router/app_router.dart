import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import 'routes_strings.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutesStrings.home,
    routes: [
      GoRoute(
        path: RoutesStrings.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
