import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';
import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/features/content/utils/content_validation.dart';

class ContentBodyField extends HookConsumerWidget {
  const ContentBodyField({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final TextEditingController controller;
  final GlobalKey<FormFieldState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: TextFormField(
        controller: controller,
        key: formKey,
        maxLength: 2000,
        maxLines: null,
        minLines: 10,
        validator: ContentValidation.validateBody,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          errorStyle: TextStyle(
            color: Colors.transparent,
          ),
          fillColor: ColorTheme.backgroundWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
