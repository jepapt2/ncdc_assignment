import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgIcon {
  plus('+'),
  cancel('cancel'),
  delete('delete'),
  logo('logo'),
  done('done'),
  edit('edit'),
  save('save');

  const SvgIcon(this.name);
  final String name;

  String get path => 'assets/svg/$name.svg';
}

class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon({
    super.key,
    required this.assetName,
    this.size = 24,
    this.color,
  });

  final SvgIcon assetName;

  final double size;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    ColorFilter? colorFilter;
    final color = this.color;
    if (color != null) {
      colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
    }

    return SvgPicture.asset(
      assetName.path,
      width: size,
      height: size,
      colorFilter: colorFilter,
    );
  }
}
