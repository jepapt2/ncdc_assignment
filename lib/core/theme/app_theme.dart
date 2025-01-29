import 'package:flutter/material.dart';
import 'color_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ColorTheme.brand,
      scaffoldBackgroundColor: ColorTheme.backgroundWhite,
    );
  }
}
