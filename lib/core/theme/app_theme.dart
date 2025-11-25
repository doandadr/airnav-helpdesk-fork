import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[50],
      cardColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.light,
        primary: const Color(0xFF0D47A1),
        onPrimary: Colors.white,
        secondary: const Color(0xFF0F3C5C),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.grey[900]!,
        outline: Colors.grey[200],
      ),
      textTheme: GoogleFonts.montserratTextTheme(),
      dividerTheme: DividerThemeData(color: Colors.grey[100]),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.dark,
        primary: const Color(0xFF0D47A1), // Lighter blue for dark mode
        onPrimary: const Color.fromARGB(255, 255, 255, 255),
        secondary: const Color(0xFF0F3C5C),
        onSecondary: Colors.white,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        outline: Colors.grey[800],
      ),
      textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      dividerTheme: DividerThemeData(color: Colors.grey[800]),
    );
  }
}
