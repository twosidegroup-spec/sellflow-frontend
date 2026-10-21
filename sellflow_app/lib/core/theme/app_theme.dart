import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2f5fb7);
  static const Color accent = Color(0xFF214195);
  static const Color secondary = Color(0xFF539ede);
  static const Color link = Color(0xFF407fd0);
  static const Color background = Color(0xFF1a1a1a);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFFa0a0a0);
  static const Color border = Color(0xFF333333);
  static const Color lightGray = Color(0xFF2a2a2a);
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF059669);

  static const String fontFamily = 'Inter';

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: background,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: lightGray,
        error: error,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          color: gray,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontFamily: fontFamily,
          color: gray,
          fontSize: 13,
        ),
      ),
    );
  }
}
