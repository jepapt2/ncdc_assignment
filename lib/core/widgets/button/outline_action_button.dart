import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';

class OutlineActionButton extends StatelessWidget {
  const OutlineActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isDisabled = false,
    this.size = ButtonSize.small,
    this.colorTheme = const BrandOutlineButtonColorTheme(),
  });

  final ButtonSize? size;
  final VoidCallback? onPressed;
  final String label;
  final SvgIcon icon;
  final bool isDisabled;
  final OutlineButtonColorTheme colorTheme;

  Color get currentForegroundColor => isDisabled
      ? colorTheme.disabledForegroundColor
      : colorTheme.foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 40,
          width: ButtonSize.large == size ? 90 : 40,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              disabledForegroundColor: colorTheme.disabledForegroundColor,
              disabledBackgroundColor: colorTheme.backgroundColor,
              backgroundColor: colorTheme.backgroundColor,
              foregroundColor: colorTheme.foregroundColor,
              overlayColor: colorTheme.pressedBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: currentForegroundColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSvgIcon(
                  assetName: icon,
                  size: 24,
                  color: currentForegroundColor,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: currentForegroundColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
