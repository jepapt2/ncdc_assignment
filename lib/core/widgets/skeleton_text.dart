import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';

class SkeletonText extends StatelessWidget {
  const SkeletonText({
    super.key,
    this.width,
    this.height = 16,
    this.baseColor,
    this.highlightColor,
  });

  /// スケルトンの幅（nullの場合は親の幅に合わせる）
  final double? width;

  /// スケルトンの高さ
  final double? height;

  /// ベースカラー（nullの場合はデフォルト値を使用）
  final Color? baseColor;

  /// ハイライトカラー（nullの場合はデフォルト値を使用）
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.black12,
      highlightColor: highlightColor ?? ColorTheme.backgroundLight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
}
