import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppPageTransition {
  none,
  fade,
  slideFromRight,
  slideFromBottom,
}

abstract final class AppPageTransitions {
  static const duration = Duration(milliseconds: 300);

  static Page<T> build<T>({
    required LocalKey key,
    required Widget child,
    AppPageTransition transition = AppPageTransition.fade,
    Duration? transitionDuration,
  }) {
    final resolvedDuration = transitionDuration ?? duration;

    return switch (transition) {
      AppPageTransition.none => NoTransitionPage<T>(key: key, child: child),
      AppPageTransition.fade => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            fade(animation, child),
      ),
      AppPageTransition.slideFromRight => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            slideFromRight(animation, child),
      ),
      AppPageTransition.slideFromBottom => CustomTransitionPage<T>(
        key: key,
        child: child,
        transitionDuration: resolvedDuration,
        reverseTransitionDuration: resolvedDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            slideFromBottom(animation, child),
      ),
    };
  }

  static Page<T> fromState<T>({
    required GoRouterState state,
    required Widget child,
    AppPageTransition transition = AppPageTransition.fade,
    Duration? transitionDuration,
  }) {
    return build<T>(
      key: state.pageKey,
      child: child,
      transition: transition,
      transitionDuration: transitionDuration,
    );
  }

  static Widget fade(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  static Widget slideFromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }

  static Widget slideFromBottom(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }
}
