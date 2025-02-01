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
        color: ColorTheme.textRegular,
      ),
      // bodyテキスト
      bodyMedium: GoogleFonts.notoSansJp(
        fontSize: 16,
        color: ColorTheme.textRegular,
      ),
      // キャプション
      bodySmall: GoogleFonts.notoSansJp(
        fontSize: 12,
        color: ColorTheme.textRegular,
      ),
      // ミニテキスト
      labelSmall: GoogleFonts.notoSansJp(
        fontSize: 10,
        color: ColorTheme.textRegular,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      textTheme: textTheme,
      scaffoldBackgroundColor: ColorTheme.backgroundWhite,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: ColorTheme.backgroundLight,
      ),
    );
  }
}
