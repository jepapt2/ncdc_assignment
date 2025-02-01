import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isDisabled = false,
  });

  final VoidCallback onPressed;
  final SvgIcon icon;
  final bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(
        NormalButtonColorTheme().hoverBackgroundColor,
      ),
      borderRadius: BorderRadius.circular(4),
      onTap: isDisabled ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: AppSvgIcon(
          assetName: icon,
          color: isDisabled
              ? NormalButtonColorTheme().disabledBackgroundColor
              : NormalButtonColorTheme().backgroundColor,
          size: 20,
        ),
      ),
    );
  }
}
