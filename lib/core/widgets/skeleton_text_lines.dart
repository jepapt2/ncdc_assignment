import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/widgets/skeleton_text.dart';

class SkeletonTextLines extends StatelessWidget {
  const SkeletonTextLines({
    super.key,
    this.fontSize = 16,
  });

  /// フォントサイズ
  final double fontSize;

  Widget _buildParagraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            4,
            (index) => Column(
                  children: [
                    SkeletonText(height: fontSize),
                    const SizedBox(height: 8),
                  ],
                )),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: SkeletonText(height: fontSize),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            6,
            (index) => Column(
                  children: [
                    _buildParagraph(),
                    const SizedBox(height: 32),
                  ],
                )),
      ],
    );
  }
}
