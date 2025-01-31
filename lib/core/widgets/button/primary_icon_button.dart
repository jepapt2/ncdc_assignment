import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';

enum ButtonSize {
  small,
  large,
}

class PrimaryIconFillButton extends StatelessWidget {
  const PrimaryIconFillButton({
    super.key,
    required this.onPressed,
    required this.type,
    this.size = ButtonSize.small,
    this.isDisabled = false,
    this.backgroundColor = PrimaryButtonColorTheme.normal,
    this.pressBackgroundColor = PrimaryButtonColorTheme.pressed,
    this.disabledBackgroundColor = const Color.fromARGB(120, 76, 179, 248),
    this.foregroundColor = ColorTheme.backgroundWhite,
  });

  final ButtonSize size;

  /// ボタンがタップされたときのコールバック
  final VoidCallback? onPressed;

  /// ボタンの種類
  final SvgIcon type;

  /// ボタンが無効かどうか
  final bool isDisabled;

  /// ボタンの背景色
  final Color backgroundColor;

  /// ボタンが押されたときの背景色
  final Color pressBackgroundColor;

  /// ボタンが無効のときの背景色
  final Color disabledBackgroundColor;

  /// ボタンのテキスト色
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: ButtonSize.large == size ? 90 : 40,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          disabledBackgroundColor: disabledBackgroundColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          overlayColor: pressBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgIcon(assetName: type, size: 24),
            const SizedBox(width: 4),
            Text(
              type.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryIconOutlineButton extends StatelessWidget {
  const PrimaryIconOutlineButton({
    super.key,
    required this.onPressed,
    required this.type,
    this.isDisabled = false,
    this.size = ButtonSize.small,
    this.backgroundColor = PrimaryOutlineButtonColorTheme.normal,
    this.pressBackgroundColor = PrimaryOutlineButtonColorTheme.pressed,
    this.foregroundColor = PrimaryButtonColorTheme.normal,
    this.disabledForegroundColor = PrimaryOutlineButtonColorTheme.disabled,
  });

  /// ボタンがタップされたときのコールバック
  final VoidCallback? onPressed;

  /// ボタンの種類
  final SvgIcon type;

  /// ボタンが無効かどうか
  final bool isDisabled;

  /// ボタンの背景色
  final Color backgroundColor;

  /// ボタンが押されたときの背景色
  final Color pressBackgroundColor;

  /// ボタンが無効のときのテキスト色
  final Color disabledForegroundColor;

  /// ボタンのテキスト色
  final Color foregroundColor;

  /// ボタンのサイズ
  final ButtonSize size;

  Color get currentForegroundColor =>
      isDisabled ? disabledForegroundColor : foregroundColor;

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
              disabledForegroundColor: disabledForegroundColor,
              disabledBackgroundColor: backgroundColor,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              overlayColor: pressBackgroundColor,
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
                  assetName: type,
                  size: 24,
                  color: currentForegroundColor,
                ),
                const SizedBox(width: 4),
                Text(
                  type.label,
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
