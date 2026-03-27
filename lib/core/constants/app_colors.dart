import 'package:flutter/material.dart';

/// App color palette for JapaLyze
class AppColors {
  AppColors._();

  // Primary Colors (Blue)
  static const Color primary = Color(0xFF2979FF);
  static const Color primaryLight = Color(0xFF5A8BFF);
  static const Color primaryDark = Color(0xFF0038C7);

  // Secondary Colors
  static const Color secondary = Color(0xFF37474F);
  static const Color secondaryLight = Color(0xFF62727B);
  static const Color secondaryDark = Color(0xFF102027);

  // Light Theme - Neutral Colors
  static const Color background = Color(0xFFF0F2F5);
  static const Color surface = Color(0xFFFFFFFF);

  // Dark Theme - Neutral Colors
  static const Color backgroundDark = Color(0xFF0D141C);
  static const Color surfaceDark = Color(0xFF1A2332);

  // Text Colors (Light Theme)
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);

  // Text Colors (Dark Theme)
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

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
