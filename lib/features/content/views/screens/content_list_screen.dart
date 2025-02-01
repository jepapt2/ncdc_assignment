import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/widgets/button/fill_action_button.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';
import 'package:ncdc_assignment/core/widgets/button/outline_action_button.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:ncdc_assignment/features/content/widgets/content_list.dart';
import 'package:ncdc_assignment/features/content/widgets/content_save_dialog.dart';
import '../../../../core/theme/color_theme.dart';

class ContentListScreen extends StatelessWidget {
  const ContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: Row(
          children: [
            AppSvgIcon(assetName: SvgIcon.logo, size: 24),
            const SizedBox(width: 4),
            Text(
              'ServiceName',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontFamily: 'Gotham',
                  ),
            ),
          ],
        ),
        backgroundColor: ColorTheme.backgroundWhite,
        shape: Border(
          bottom: BorderSide(
            color: ColorTheme.backgroundLight,
            width: 1,
          ),
        ),
      ),
      body: ContentList(),
      bottomNavigationBar: BottomAppBar(
        color: ColorTheme.backgroundLight,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer(builder: (context, ref, child) {
          final isEditing = ref.watch(isEditingContentListProvider);
          final isEditingNotifier =
              ref.read(isEditingContentListProvider.notifier);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isEditing
                ? [
                    OutlineActionButton(
                      label: 'New Page',
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => ContentSaveDialog(),
                      ),
                      size: ButtonSize.large,
                      icon: SvgIcon.plus,
                    ),
                    FillActionButton(
                      label: 'Done',
                      onPressed: () => isEditingNotifier.endEditing(),
                      size: ButtonSize.large,
                      icon: SvgIcon.done,
                    ),
                  ]
                : [
                    const SizedBox(),
                    FillActionButton(
                      label: 'Edit',
                      onPressed: () => isEditingNotifier.startEditing(),
                      size: ButtonSize.large,
                      icon: SvgIcon.edit,
                    ),
                  ],
          );
        }),
      ),
    );
  }
}
