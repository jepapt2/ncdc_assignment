import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';
import 'package:ncdc_assignment/core/widgets/button/fill_action_button.dart';
import 'package:ncdc_assignment/core/widgets/skeleton_text.dart';
import 'package:ncdc_assignment/core/widgets/skeleton_text_lines.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_detail_provider/content_detail_provider.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:ncdc_assignment/features/content/widgets/content_body_field.dart';
import 'package:ncdc_assignment/features/content/widgets/content_save_dialog.dart';

class ContentDetailScreen extends HookConsumerWidget {
  const ContentDetailScreen({
    super.key,
    required this.contentId,
  });

  final int contentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final contentState = ref.watch(contentDetailProvider(contentId));
    final isEditing = ref.watch(isEditingContentDetailProvider);
    final isEditingNotifier =
        ref.watch(isEditingContentDetailProvider.notifier);
    final isSaveLoading = ref.watch(isSaveLoadingProvider);
    final bodyController = useTextEditingController();

    final bodyFormKey = GlobalKey<FormFieldState>();

    // contentStateが変更されたらbodyControllerの値を更新
    useEffect(() {
      if (contentState.hasValue) {
        bodyController.text = contentState.value?.body ?? '';
      }
      return null;
    }, [contentState]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.backgroundLight,
        title: contentState.isLoading
            ? SkeletonText(width: 140)
            : Text(contentState.valueOrNull?.title ?? '',
                style: textTheme.titleMedium),
        actions: [
          Visibility(
            visible: contentState.hasValue,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: FillActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ContentSaveDialog(
                      editContent: contentState.value,
                    ),
                  );
                },
                icon: SvgIcon.edit,
                label: 'Edit',
              ),
            ),
          )
        ],
      ),
      body: contentState.when(
        data: (content) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 60),
                child: isEditing
                    ? ContentBodyField(
                        controller: bodyController,
                        formKey: bodyFormKey,
                      )
                    : Container(
                        padding: const EdgeInsets.all(30),
                        child: Text(content.body ?? ''),
                      ),
              ),
            ),
          ],
        ),
        loading: () => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(30),
          child: SkeletonTextLines(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'コンテンツの読み込みに失敗しました',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.invalidate(contentDetailProvider(contentId));
                },
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        height: 40,
        color: ColorTheme.backgroundLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Copyright © 2021 Sample', style: textTheme.labelMedium),
            Text('運営会社', style: textTheme.labelMedium),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: contentState.hasValue,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: isEditing
                ? [
                    FillActionButton(
                      label: 'Cancel',
                      onPressed: () => isEditingNotifier.endEditing(),
                      icon: SvgIcon.cancel,
                      colorTheme: NormalButtonColorTheme(),
                    ),
                    FillActionButton(
                      isDisabled: isSaveLoading,
                      label: 'Save',
                      onPressed: () {
                        if (!bodyFormKey.currentState!.validate()) return;
                        if (contentState.hasValue) {
                          final updatedContent = CreateContentDTO(
                            body: bodyController.text,
                          );
                          ref
                              .read(contentDetailProvider(contentId).notifier)
                              .updateContent(updatedContent);
                        }
                      },
                      icon: SvgIcon.save,
                    ),
                  ]
                : [
                    FillActionButton(
                      label: 'Edit',
                      onPressed: () => isEditingNotifier.startEditing(),
                      icon: SvgIcon.edit,
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
