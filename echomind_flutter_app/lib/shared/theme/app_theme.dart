import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    const base = Color(0xFFF5F6FB);
    const card = Colors.white;
    const accent = Color(0xFF1677FF);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: base,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.light,
      ),
      cardTheme: const CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
      dividerColor: const Color(0xFFE5E7EB),
    );
  }
}
