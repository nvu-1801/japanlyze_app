import 'package:flutter/material.dart';

/// App color palette for JapaLyze
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary Colors
  static const Color secondary = Color(0xFFF43F5E);
  static const Color secondaryLight = Color(0xFFFB7185);
  static const Color secondaryDark = Color(0xFFE11D48);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFFF1F5F9);

  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // JLPT Level Colors
  static const Color jlptN5 = Color(0xFF22C55E);
  static const Color jlptN4 = Color(0xFF84CC16);
  static const Color jlptN3 = Color(0xFFF59E0B);
  static const Color jlptN2 = Color(0xFFF97316);
  static const Color jlptN1 = Color(0xFFEF4444);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
