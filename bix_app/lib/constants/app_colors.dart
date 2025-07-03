import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFF6B6B);
  static const Color secondary = Color(0xFF4ECDC4);
  static const Color accent = Color(0xFF45B7D1);
  
  // Background Colors
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color cardBackground = Color(0xFF2A2A2A);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF808080);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Social Colors
  static const Color like = Color(0xFFE91E63);
  static const Color comment = Color(0xFF9C27B0);
  static const Color share = Color(0xFF00BCD4);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient videoOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0x80000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Opacity Colors
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  // Glass Effect Colors
  static Color glassBackground = Colors.white.withOpacity(0.1);
  static Color glassBorder = Colors.white.withOpacity(0.2);
}