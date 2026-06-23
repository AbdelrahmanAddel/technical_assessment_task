import 'package:flutter/material.dart';

@immutable
abstract class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.text,
    required this.border,
    required this.error,
  });

  final Color primary;
  final Color background;
  final Color surface;
  final Color text;
  final Color border;
  final Color error;

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? text,
    Color? border,
    Color? error,
  });

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return _AppColorTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      border: Color.lerp(border, other.border, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

class LightAppColors extends AppColors {
  const LightAppColors()
    : super(
        primary: const Color(0xFF2563EB),
        background: const Color(0xFFF8FAFC),
        surface: const Color(0xFFFFFFFF),
        text: const Color(0xFF111827),
        border: const Color(0xFFE5E7EB),
        error: const Color(0xFFDC2626),
      );

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? text,
    Color? border,
    Color? error,
  }) {
    return _AppColorTokens(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      border: border ?? this.border,
      error: error ?? this.error,
    );
  }
}

class DarkAppColors extends AppColors {
  const DarkAppColors()
    : super(
        primary: const Color(0xFF93C5FD),
        background: const Color(0xFF0F172A),
        surface: const Color(0xFF111827),
        text: const Color(0xFFF8FAFC),
        border: const Color(0xFF334155),
        error: const Color(0xFFF87171),
      );

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? text,
    Color? border,
    Color? error,
  }) {
    return _AppColorTokens(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      border: border ?? this.border,
      error: error ?? this.error,
    );
  }
}

class _AppColorTokens extends AppColors {
  const _AppColorTokens({
    required super.primary,
    required super.background,
    required super.surface,
    required super.text,
    required super.border,
    required super.error,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? text,
    Color? border,
    Color? error,
  }) {
    return _AppColorTokens(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      border: border ?? this.border,
      error: error ?? this.error,
    );
  }
}
