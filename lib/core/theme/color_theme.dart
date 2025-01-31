import 'package:flutter/material.dart';

class ColorTheme {
  // メインカラー
  static const Color brand = Color(0xFF4CB3F8); // light blue #4CB3F8

  // テキストカラー
  static const Color textRegular = Color(0xFF333333); // black80 #333333
  static const Color textLight = Color(0xFF4D4D4D); // black50 #4D4D4D

  // 背景色
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F8FA);
  static const Color backgroundDark = Color(0xFFC8E6FA);
}

class PrimaryButtonColorTheme {
  static const Color normal = ColorTheme.brand;
  static const Color pressed = Color(0xFF347CAB);
  static const Color disabled = Color.fromARGB(125, 76, 179, 248);
}

class PrimaryOutlineButtonColorTheme {
  static const Color normal = ColorTheme.backgroundWhite;
  static const Color pressed = Color(0xFFB3B3B3);
  static const Color disabled = Color.fromARGB(125, 76, 179, 248);
}

class SecondaryButtonColorTheme {
  static const Color normal = Color(0xFF8B8B8B);
  static const Color pressed = Color(0xFF8B8B8B);
  static const Color disabled = Color(0xFF8B8B8B);
}
