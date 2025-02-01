import 'package:flutter/material.dart';
import 'package:ncdc_assignment/core/widgets/skeleton_text.dart';

class ContentListTileSkeleton extends StatelessWidget {
  const ContentListTileSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          minVerticalPadding: 10,
          title: SkeletonText(
            height: 16,
          ),
        );
      },
    );
  }
}
