import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF5785);    // Rosa
  static const Color secondary = Color(0xFF6AC7E6);  // Azul claro
  static const Color tertiary = Color(0xFFFFC4C8);   // Rosa claro
  static const Color background = Color(0xFFF1F4F8); // Gris muy claro

  // Variantes con opacidad para gradientes
  static Color primaryLight = primary.withValues(alpha: 0.1);
  static Color secondaryLight = secondary.withValues(alpha: 0.1);
  static Color tertiaryLight = tertiary.withValues(alpha: 0.1);
}
