import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppPageTransition {
  none,
  fade,
  slideFromRight,
  slideFromBottom,
}

abstract final class AppPageTransitions {
  static const _duration = Duration(milliseconds: 300);

  static Page<T> build<T>({
    required LocalKey key,
    required Widget child,
    AppPageTransition transition = AppPageTransition.fade,
    Duration? duration,
  }) {
    final resolvedDuration = duration ?? _duration;

    return switch (transition) {
      AppPageTransition.none => NoTransitionPage<T>(key: key, child: child),
      AppPageTransition.fade => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: _fade,
      ),
      AppPageTransition.slideFromRight => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: _slideFromRight,
      ),
      AppPageTransition.slideFromBottom => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: _slideFromBottom,
      ),
    };
  }

  static Page<T> fromState<T>({
    required GoRouterState state,
    required Widget child,
    AppPageTransition transition = AppPageTransition.fade,
    Duration? duration,
  }) {
    return build<T>(
      key: state.pageKey,
      child: child,
      transition: transition,
      duration: duration,
    );
  }

  static Widget _fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  static Widget _slideFromRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: child,
    );
  }

  static Widget _slideFromBottom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: child,
    );
  }
}
