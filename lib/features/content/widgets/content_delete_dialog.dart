import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';
import 'package:ncdc_assignment/core/widgets/button/fill_action_button.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';

class ContentDeleteDialog extends StatelessWidget {
  const ContentDeleteDialog({
    super.key,
    required this.content,
    required this.dialogContext,
  });

  final Content content;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text('コンテンツの削除', style: textTheme.bodyMedium),
      content:
          Text('${content.title}を削除してもよろしいですか？', style: textTheme.bodySmall),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
          children: [
            FillActionButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgIcon.cancel,
              label: 'Cancel',
              colorTheme: NormalButtonColorTheme(),
              size: ButtonSize.large,
            ),
            Consumer(builder: (_, ref, child) {
              return FillActionButton(
                isDisabled: ref.watch(isSaveLoadingProvider),
                onPressed: () async {
                  final result = await ref
                      .read(contentListProvider.notifier)
                      .delete(content);
                  if (result && context.mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: SvgIcon.delete,
                label: 'Delete',
                size: ButtonSize.large,
              );
            }),
          ],
        ),
      ],
    );
  }
}
