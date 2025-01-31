import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';

enum ButtonSize {
  small,
  large,
}

abstract class FillButtonColorTheme {
  const FillButtonColorTheme();

  Color get backgroundColor;
  Color get pressedBackgroundColor;
  Color get disabledBackgroundColor;
  Color get foregroundColor;
}

class BrandButtonColorTheme extends FillButtonColorTheme {
  const BrandButtonColorTheme();

  @override
  Color get backgroundColor => ColorTheme.brand;
  @override
  Color get pressedBackgroundColor => const Color(0xFF347CAB);
  @override
  Color get disabledBackgroundColor => const Color.fromARGB(125, 76, 179, 248);
  @override
  Color get foregroundColor => ColorTheme.backgroundWhite;
}

class NormalButtonColorTheme extends FillButtonColorTheme {
  const NormalButtonColorTheme();

  @override
  Color get backgroundColor => const Color(0xFFB3B3B3);
  @override
  Color get pressedBackgroundColor => const Color(0xFF808080);
  @override
  Color get disabledBackgroundColor => const Color.fromARGB(80, 139, 139, 139);
  @override
  Color get foregroundColor => ColorTheme.backgroundWhite;
}

abstract class OutlineButtonColorTheme {
  const OutlineButtonColorTheme();

  Color get backgroundColor;
  Color get pressedBackgroundColor;
  Color get foregroundColor;
  Color get disabledForegroundColor;
}

class BrandOutlineButtonColorTheme extends OutlineButtonColorTheme {
  const BrandOutlineButtonColorTheme();

  @override
  Color get backgroundColor => ColorTheme.backgroundWhite;
  @override
  Color get pressedBackgroundColor => const Color(0xFFB3B3B3);
  @override
  Color get foregroundColor => ColorTheme.brand;
  @override
  Color get disabledForegroundColor => const Color.fromARGB(125, 76, 179, 248);
}
