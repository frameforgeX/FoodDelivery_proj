import 'package:flutter/material.dart';

/// Centralized color palette for the entire application
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF8B0000); // Deep Red
  static const Color primaryLight = Color(0xFFD32F2F); // Lighter Red
  static const Color primaryDark = Color(0xFF5D0000); // Darker Red

  // Secondary Colors
  static const Color secondary = Color(0xFFFFA500); // Orange
  static const Color secondaryLight = Color(0xFFFFB74D); // Light Orange
  static const Color secondaryDark = Color(0xFFF57C00); // Dark Orange

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF808080);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF333333);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFBC02D);
  static const Color info = Color(0xFF1976D2);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF9E9E9E);

  // Shadow/Border Colors
  static const Color shadow = Color(0x29000000);
  static const Color border = Color(0xFFE0E0E0);

  // Gradient Colors
  static const List<Color> gradientPrimary = [primary, primaryLight];
  static const List<Color> gradientSecondary = [secondary, secondaryDark];
}
