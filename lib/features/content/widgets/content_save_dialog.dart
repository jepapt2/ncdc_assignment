import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/button_color_theme.dart';
import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';
import 'package:ncdc_assignment/core/widgets/button/fill_action_button.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_detail_provider/content_detail_provider.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:ncdc_assignment/features/content/utils/content_validation.dart';

class ContentSaveDialog extends HookWidget {
  ContentSaveDialog({
    super.key,
    this.editContent,
  });

  final Content? editContent;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: editContent?.title);
    final textTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth * 0.8;

    Future<void> handleSave(WidgetRef ref) async {
      if (!_formKey.currentState!.validate()) return;

      final existingContent = editContent;
      // 新規作成
      if (existingContent == null) {
        final result = await ref
            .read(contentListProvider.notifier)
            .create(CreateContentDTO(title: titleController.text));
        if (result == null || !context.mounted) return;
        final navigator = Navigator.of(context);
        navigator.pop(context);
        context.push('/content/${result.id}');
        return;
      }
      final result = await ref
          .read(contentDetailProvider(existingContent.id).notifier)
          .updateContent(CreateContentDTO(title: titleController.text));
      if (!context.mounted || result == null) return;
      Navigator.pop(context);
    }

    return SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        children: [
          Container(
              padding: EdgeInsets.all(20),
              width: dialogWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('コンテンツの作成', style: textTheme.bodyMedium),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        maxLines: 1,
                        maxLength: 100,
                        style: textTheme.bodyMedium,
                        controller: titleController,
                        validator: ContentValidation.validateTitle,
                      ),
                    ),
                  ),
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
                        final isSaveLoading = ref.watch(isSaveLoadingProvider);

                        return FillActionButton(
                          isDisabled: isSaveLoading,
                          onPressed: () async {
                            await handleSave(ref);
                          },
                          icon: SvgIcon.save,
                          label: 'Save',
                          size: ButtonSize.large,
                        );
                      }),
                    ],
                  ),
                ],
              ))
        ]);
  }
}
