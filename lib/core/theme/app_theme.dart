import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = ThemeData.light().textTheme;
    final textTheme = GoogleFonts.notoSansJpTextTheme(baseTextTheme).copyWith(
      // 見出し
      titleMedium: GoogleFonts.notoSansJp(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      // bodyテキスト
      bodyMedium: GoogleFonts.notoSansJp(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      // キャプション
      bodySmall: GoogleFonts.notoSansJp(
        fontSize: 12,
        height: 1.4,
        letterSpacing: 0.4,
      ),
      // ミニテキスト
      labelSmall: GoogleFonts.notoSansJp(
        fontSize: 10,
        height: 1.4,
        letterSpacing: 0.4,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      textTheme: textTheme,
      scaffoldBackgroundColor: ColorTheme.backgroundWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        onPrimary: Colors.white,
      ),
      splashColor: Colors.blue.withOpacity(0.1),
      highlightColor: Colors.blue.withOpacity(0.05),
    );
  }
}
