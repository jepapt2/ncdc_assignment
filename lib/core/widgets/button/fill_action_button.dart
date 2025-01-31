import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';

class FillActionButton extends StatelessWidget {
  const FillActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.size = ButtonSize.small,
    this.isDisabled = false,
    this.colorTheme = const BrandButtonColorTheme(),
  });

  final ButtonSize size;
  final String label;
  final VoidCallback? onPressed;
  final SvgIcon icon;
  final bool isDisabled;
  final FillButtonColorTheme colorTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: ButtonSize.large == size ? 90 : 40,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          disabledBackgroundColor: colorTheme.disabledBackgroundColor,
          backgroundColor: colorTheme.backgroundColor,
          foregroundColor: colorTheme.foregroundColor,
          overlayColor: colorTheme.pressedBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgIcon(
              assetName: icon,
              size: 24,
              color: colorTheme.foregroundColor,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorTheme.foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
