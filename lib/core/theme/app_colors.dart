import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceHighlight,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.onAccent,
    required this.onStatus,
  });

  final Color background;
  final Color surface;
  final Color surfaceHighlight;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color onAccent;
  final Color onStatus;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHighlight,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? accent,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? onAccent,
    Color? onStatus,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      accent: accent ?? this.accent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      onAccent: onAccent ?? this.onAccent,
      onStatus: onStatus ?? this.onStatus,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHighlight: Color.lerp(surfaceHighlight, other.surfaceHighlight, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      onStatus: Color.lerp(onStatus, other.onStatus, t)!,
    );
  }

  // Light Theme Palette
  static const light = AppColors(
    background: Color(0xFFF7F9FC), // Neutral light background
    surface: Color(0xFFFFFFFF),
    surfaceHighlight: Color(0xFFF0F2F5),
    border: Color(0xFFE0E6ED),
    textPrimary: Color(0xFF1A1F2C),
    textSecondary: Color(0xFF64748B),
    textTertiary: Color(0xFF94A3B8),
    accent: Color(0xFF3B82F6), // Blue
    success: Color(0xFF10B981), // Green
    warning: Color(0xFFF59E0B), // Amber
    error: Color(0xFFEF4444), // Red
    info: Color(0xFF6366F1), // Indigo
    onAccent: Colors.white,
    onStatus: Colors.white,
  );

  // Dark Theme Palette
  static const dark = AppColors(
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceHighlight: Color(0xFF334155),
    border: Color(0xFF334155),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textTertiary: Color(0xFF64748B),
    accent: Color(0xFF60A5FA),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
    info: Color(0xFF818CF8),
    onAccent: Colors.white,
    onStatus: Colors.black,
  );
}
